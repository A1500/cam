package com.inspur.cams.comm.baseinfo.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;


/**
 * @title:IBaseinfoPeopleDao
 * @description:
 * @author:
 * @since:2011-05-12
 * @version:1.0
*/
 public interface IBaseinfoPeopleDao extends BaseCURD<BaseinfoPeople>{
	public void save(List<BaseinfoPeople> list);
	public void bathchDeleteByFamilyId(String[] jtid);
	public DataSet itemQuery(ParameterSet pset);
	public void batchDeleteByBaseinfoFamily(String[] familyId);
	/**
	 * 一站式救助人员信息查询
	 * @param paramSet
	 * @return
	 */
	public DataSet queryForMBalance(ParameterSet paramSet);
	/**
	 * 低保救助人员信息查询
	 * @param paramSet
	 * @return
	 */
	public DataSet queryForSam(ParameterSet paramSet);
	
	/**
	 * 批量删除家庭成员信息
	 * @param peopleId
	 */
	public void batchDeleteByBaseinfoPeople(String[] peopleId);
	
	/**
	 * 根据FAMILY_ID查询PEOPLE_ID
	 * @param familyIds
	 * @return
	 */
	public String[] getPeopleIdsByFamilyIds(String[] familyIds);
	/**
	 * 根据PEOPLE_ID查询人员基本信息
	 * @param PEOPLE_ID
	 * @return
	 */
	public DataSet queryDemobilizedFlowHeader(String peopleId);
	/**
	 * 根据身份证号查询是否属于低保五保
	 * @param idCard 身份证号
	 * @return
	 */
	public DataSet queryForInterface(String idCard);

	/**
	 * @Title: querySamPeopleList 
	 * @Description: TODO(低保对象查询列表) 
	 * @author wangziming
	 */
	public DataSet querySamPeopleList(ParameterSet pset);
	/**
	* @Title: insertPeoFromEnsurey
	* @Description: TODO(从经济核对回填人员信息)
	* @param set void  
	* @throws
	* @author luguosui
	 */
	public void insertFamilyFromEnsurey(ParameterSet set);
	/**
	 * 可能成为五保对象的人员查询
	 * @return
	 */
	public DataSet queryMaybeFiveList(ParameterSet pset);
	/**
	 * @Title: queryBaseChangePeople 
	 * @Description:  (低保保障对象变动) 
	 * @author YLL
	 */
	public DataSet queryBaseChangePeople(ParameterSet pset);
	
	public DataSet queryCremationInfo(ParameterSet pset);
}