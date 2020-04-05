#!/bin/sh

conda activate clvision-challenge
( {
    set -x
    function main_ewc {
        echo main_ewc.py --sub_dir="ewc-$ewc_weight-$ewc_explosion_multr_cap-$(date '+%m%d%H%M')" --ewc_weight=$ewc_weight --ewc_explosion_multr_cap=$ewc_explosion_multr_cap
        python main_ewc.py \
            --scenario="multi-task-nc" \
            --epochs="2" \
            --sub_dir="ewc-$ewc_weight-$ewc_explosion_multr_cap-$(date '+%m%d%H%M')" \
            --ewc_weight=$ewc_weight \
            --ewc_explosion_multr_cap=$ewc_explosion_multr_cap
    }
    function main_ewc_var_weight {
        ewc_weight=50 main_ewc
        ewc_weight=100 main_ewc
        ewc_weight=150 main_ewc
        ewc_weight=200 main_ewc
        ewc_weight=300 main_ewc
        ewc_weight=500 main_ewc
        ewc_weight=1000 main_ewc
        ewc_weight=2000 main_ewc
        ewc_weight=3000 main_ewc
        ewc_weight=5000 main_ewc
    }
    python main.py --scenario="multi-task-nc" --epochs="2" --sub_dir="baseline-$(date '+%m%d%H%M')"
    ewc_explosion_multr_cap=5 main_ewc_var_weight
    ewc_explosion_multr_cap=10 main_ewc_var_weight
    ewc_explosion_multr_cap=15 main_ewc_var_weight
    ewc_explosion_multr_cap=20 main_ewc_var_weight
    ewc_explosion_multr_cap=25 main_ewc_var_weight
    ewc_explosion_multr_cap=30 main_ewc_var_weight
} |& tee "proj-$(date '+%m%d%H%M').log" &)
