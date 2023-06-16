curl -ukyle:$ART_K_PASS \
-X POST "https://demo.jfrogchina.com/xray/api/v1/summary/component" \
-H "Content-Type: application/json" \
--data-raw '{
                "component_details":[
                        {
                                "component_id": "gav://com.alibaba:fastjson:1.2.24"
                        }
                ]
        }'
