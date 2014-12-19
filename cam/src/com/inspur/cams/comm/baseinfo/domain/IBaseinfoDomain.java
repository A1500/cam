package com.inspur.cams.comm.baseinfo.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;

/**
 * 家庭与人员基础信息domain接口
 * @author shgtch
 * @date 2012-5-16
 */
public interface IBaseinfoDomain {
	/**
	 *查询家庭基本信息
	 * @return
	 */
	public BaseinfoFamily getFamily(String familyId);
	
	public DataSet queryFamily(ParameterSet pset);
	
	/**
	 * 增加家庭基本信息
	 * @param baseinfoFamily
	 */
	@Trans
	public void insertFamily(BaseinfoFamily baseinfoFamily);
	
	/**
	 * 更新家庭基本信息
	 * @param baseinfoFamily
	 */
	@Trans
	public void updateFamily(BaseinfoFamily baseinfoFamily);
	
	/**
	 * 根据人员月收入更新家庭收入
	 * @param familyId
	 */
	@Trans
	public void updateIncomeByMonth(String familyId);
	
	/**
	 * 根据人员年收入更新家庭收入
	 * @param familyId
	 */
	@Trans
	public void updateIncomeByYear(String familyId);
	
	/**
	 * 更新家庭人口信息
	 * @param familyId
	 */
	@Trans
	public void updatePeopleNum(String familyId);
	
	/**
	 *查询人员基本信息
	 * @return
	 */
	public BaseinfoPeople getPeople(String peopleId);
	
	/**
	 *查询人员基本信息
	 * @return
	 */
	public DataSet queryPeople(ParameterSet pset);
	
	/**
	 *sql查询人员基本信息
	 * @return
	 */
	public DataSet queryPeopleForSam(ParameterSet pset);
	
	/**
	 * 增加人员基本信息
	 * @param baseinfoPeople
	 */
	@Trans
	public void insertPeople(BaseinfoPeople baseinfoPeople);
	
	/**
	 * 更新人员基本信息
	 * @param baseinfoPeople
	 */
	@Trans
	public void updatePeople(BaseinfoPeople baseinfoPeople);
	
	/**
	 * 删除人员基本信息
	 * @param peopleId
	 */
	@Trans
	public void deletePeople(String peopleId);

	/**
	* @Title: querySamFamilyList
	* @Description: TODO(家庭信息列表查询，专项救助列表查询使用)
	* @param pset
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet querySamFamilyList(ParameterSet pset);

	/**
	 * @Title: querySamBankList 
	 * @Description: TODO(银行账户维护列表查询) 
	 * @author wangziming
	 */
	public DataSet querySamBankList(ParameterSet pset);

	/**
	 * @Title: queryBaseChange 
	 * @Description: TODO(低保变动) 
	 * @author wangziming
	 */
	public DataSet queryBaseChange(ParameterSet pset);
	/**
	 * @Title: querySamPeopleList 
	 * @Description: TODO(低保对象查询列表) 
	 * @author wangziming
	 */
	public DataSet querySamPeopleList(ParameterSet pset);
	
	/**
	 * 调用存储过程把记录保存到备用表中
	 */
	public void procSamFamily(BaseinfoFamily baseinfoFamily);
	/**
	* @Title: insertFamilyFromEnsurey
	* @Description: TODO(从经济核对回填家庭信息)
	* @param set void  
	* @throws
	* @author luguosui
	 */
	public Record insertFamilyFromEnsurey(ParameterSet set);
	/**
	* @Title: insertPeoFromEnsurey
	* @Description: TODO(从经济核对回填人员信息)
	* @param set void  
	* @throws
	* @author luguosui
	 */
	public void insertPeoFromEnsurey(ParameterSet set);
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
	
	public DataSet querySamFamilyListForRecheck(ParameterSet pset);
	
	public DataSet queryCremationInfo(ParameterSet pset);
}
