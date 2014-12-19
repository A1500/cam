package com.inspur.cams.bpt.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptRegularIdentification;

/**
 * @title:IBptRegularIdentificationDao
 * @description:
 * @author:
 * @since:2011-05-27
 * @version:1.0
*/
 public interface IBptRegularIdentificationDao extends BaseCURD<BptRegularIdentification>{
	public void save(List<BptRegularIdentification> list);
	
	//查询验证人员信息
	public DataSet queryRegIdenti(ParameterSet pset);
	/**
	 * 查询认证详细信息
	 */
	//public DataSet queryRIdentification(ParameterSet pset);
	//修改认证信息
	public void update(ParameterSet pSet);
	//参询是否认证
	public DataSet queryRI(ParameterSet pSet);
}
 
 

