package com.inspur.cams.bpt.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptPeopleMartyrOffspring;

/**
 * @title:IBptPeopleMartyrOffspringDao
 * @description:部分烈士（错杀被平反人员）子女 类别信息 dao层接口
 * @author:
 * @since: 
 * @version: 
*/
 public interface IBptPeopleMartyrOffspringDao extends BaseCURD<BptPeopleMartyrOffspring>{
	 public DataSet queryMartyrOffspring(ParameterSet pset);
}

