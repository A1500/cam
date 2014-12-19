package com.inspur.cams.jcm.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.jcm.data.JcmCompanyMoney;

/**
 * 工作经费信息dao
 * @author 
 * @date 2014-05-16
 */
public interface IJcmCompanyMoneyDao extends BaseCURD<JcmCompanyMoney> {
	public DataSet analysisMoney(ParameterSet pset);//同单位各年度
	public DataSet analysisMoney1(ParameterSet pset);//同年度各单位
}