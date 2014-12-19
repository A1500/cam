package com.inspur.cams.drel.sam.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

/**
 * @title:身份代码domain接口
 * @description:
 * @author:zhangjian
 * @since:2011-06-18
 * @version:1.0
 */
public interface ISamIdCardDomain {
	public DataSet query(ParameterSet pset);
	public String getIdCard(String sex,String birthday);
}
