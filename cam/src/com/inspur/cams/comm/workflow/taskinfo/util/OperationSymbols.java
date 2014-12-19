package com.inspur.cams.comm.workflow.taskinfo.util;

import java.sql.Types;

public enum OperationSymbols {
    /*通过括号赋值,而且必须有带参构造器和一属性跟方法，否则编译出错
     * 赋值必须是都赋值或都不赋值，不能一部分赋值一部分不赋值
     * 如果不赋值则不能写构造器，赋值编译也出错*/
	GATHER_EQUAL(">="), LESS_EQUAL("<="),GATHER(">"), LESS("<"),EQUAL("=");
    
    private final String value;
    public String getValue() {
        return value;
    }
    //构造器默认也只能是private, 从而保证构造函数只能在内部使用
    OperationSymbols(String value) {
        this.value = value;
    }
    
//    for (OperationSymbols c : OperationSymbols.values()) {  
//        if (c.getValue().equals(queryCondition.conditionOprationSymbol)) {  
//        	sql.append(" AND T.");
//			sql.append(queryCondition.getConditionName());
//			sql.append(queryCondition.conditionOprationSymbol);
//			sql.append(" ? ");
//			typeList.add(Types.VARCHAR);
//			argsList.add(queryCondition.getConditionValue());  
//        }  
//        return;
//    }  
}
