package com.inspur.cams.bpt.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.bpt.base.data.BptPeople;

/**
 * @title:IBptPeopleDao
 * @description:优抚人员信息
 * @author:
 * @since:2011-05-21
 * @version:1.0
*/
 public interface IBptPeopleDao extends BaseCURD<BptPeople>{
	public void save(List<BptPeople> list);
	
	/**
	 * 修改人员信息后，修改其他关联表中的相关信息，只修改审批之前表
	 */
	public void updatePeopleRelatedInfor(ParameterSet pset,Record rd);
	
	/**
	 * 查询优抚对像基本信息列表
	 * @param pset
	 * @return
	 */
	public DataSet queryBPTObjectInfo(ParameterSet pset);
	/**
	 * 查询人员各种审批信息
	 * @return
	 */
	
	public DataSet queryApplyInfo(ParameterSet pset);
	
	/**
	 * 查询优抚伤残减员人员信息
	 * @param pset
	 * @return
	 */
	public DataSet queryDecreaseBpt(ParameterSet pset);
	
	/**
	 * 查询优抚增员信息
	 * @param pset
	 * @return
	 */
	public DataSet queryIncreaseBpt(ParameterSet pset);
	/**
	 * 查询人口数量
	 * @return
	 */
	public DataSet queryPeopleNumInfo(ParameterSet pset);
	
	/**
	 * 查询优抚对像申请信息列表
	 * @param pset
	 * @return
	 */
	public DataSet queryPeopleService(ParameterSet pset);
	
	public String  getMsgForNOPrint (ParameterSet pset);
	/**
	 * 查询优抚对像基本信息列表新
	 * @param pset
	 * @return
	 */
	public DataSet queryPeopleInfo(ParameterSet pset);
	
	/**
	 * 查询60岁服兵役年限人员信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet querySoldierYear(ParameterSet pset);
	
	
	
	/**
	 * 查询身份证号重复人员信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryRepeatIdcard(ParameterSet pset) ;
	
	public void deletePeopele(ParameterSet pset);
	
	/**
	 * 查询双重身份人员
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryDoubleIdentity(ParameterSet pset);
}

