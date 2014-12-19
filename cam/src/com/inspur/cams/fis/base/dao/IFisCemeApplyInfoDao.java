package com.inspur.cams.fis.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.base.data.FisCemeApplyInfo;

/**
 * 公墓审批业务表dao
 * @author 
 * @date 2013-08-01
 */
public interface IFisCemeApplyInfoDao extends BaseCURD<FisCemeApplyInfo> {

	/**
	 * 查询业务表和公墓表方法
	 * @param pset
	 * @return
	 */
	public DataSet queryCreate(ParameterSet pset);
	/**
	 * 查询业务表,公墓表和扩建表方法
	 * @param pset
	 * @return
	 */
	public DataSet queryExpend(ParameterSet pset);
	
	public DataSet queryPreOrganId(ParameterSet pset);
	
	

	public DataSet queryDaiban(ParameterSet pset);
	public DataSet queryPublic(ParameterSet pset);
	DataSet queryCeme(ParameterSet pset);
	
	public DataSet queryCemeApply(ParameterSet pset);
	
	public void cemeLogoffDelete(ParameterSet pset);
	
	public void deleteAll(ParameterSet pset);
	
	public void deleteCreate(ParameterSet pset);
	
	public void deleteExpend(ParameterSet pset);


	public DataSet queryByCurActicity(ParameterSet pset);
	public void deleteAcceptance(ParameterSet pset);
	public DataSet queryYS(ParameterSet pset);

}