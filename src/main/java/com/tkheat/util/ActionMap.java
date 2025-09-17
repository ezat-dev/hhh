package com.tkheat.util;

import java.util.HashMap;
import java.util.Map;

public class ActionMap {

    Map<String, Object> actionMap = new HashMap<String, Object>();

   
    public String getReturnAction(String tagName) {
        if (tagName.startsWith("alarm_")) {
            return "c";
        }
        return "v"; 
    }

   
    public String getReturnAction(Map<String, Object> tagInfo) {
        String tagName = tagInfo.get("tagName").toString();
        String tagType = tagInfo.get("tagType").toString();

        if ("analog".equals(tagType)) {
            return "value";            
        } else if (tagName.startsWith("alarm_")) {
            return "c"; 
        } else {
            return "v"; 
        }
    }
}
