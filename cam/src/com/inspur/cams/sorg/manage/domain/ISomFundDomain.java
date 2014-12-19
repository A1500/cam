package com.inspur.cams.sorg.manage.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomAccount;
import com.inspur.cams.sorg.base.data.SomEntity;
import com.inspur.cams.sorg.base.data.SomMeeting;
import com.inspur.cams.sorg.base.data.SomOffice;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomPeople;
/**
 * 
 * @author Jiangzhaobao
 *
 * @date 2011年5月24日19:26:06
 */
public interface ISomFundDomain {
	
	// --------------------------------------------muqi----------------------------------------------------
	/**
	 * 保存社会组织和法定代表人信息
	 * 
	 * @param dataBean
	 */
	@Trans
	public void saveMain(SomOrgan dataBean,String sorgType);
	
	/**
	 * 更新社会组织和法定代表人信息
	 * 
	 * @param dataBean
	 */
	@Trans
	public void updateMain(SomOrgan dataBean);
	/**
	 * 保存负责人信息
	 * @param sorgId
	 * @param dataBean
	 */
	@Trans
	public void savePeople(SomPeople dataBean);
	/**
	 * 更新负责人信息
	 * @param sorgId
	 * @param dataBean
	 */
	@Trans
	public void updatePeople(SomPeople dataBean);
	/**
	 * 注销负责人信息
	 * @param peopleId
	 * @param sorgId
	 */
	@Trans
	public void cancelPeople(String sorgId,String memberId);
	/**
	 * 保存社会组织注销和清算人员信息
	 * 
	 * @param dataBean
	 */
	@Trans
	public void saveCancel(SomOrgan dataBean);
	/**
	 * 保存社会组织的撤销操作
	 * 
	 * @param dataBean
	 */
	@Trans
	public void saveRepeal(String sorgId);
	
	/**
	 * 保存分支机构信息
	 * 
	 * @param dataBean
	 */
	@Trans
	public void saveBranch(SomOrgan dataBean,String sorgType);
	/**
	 * 更新分支机构信息
	 * 
	 * @param dataBean
	 */
	@Trans
	public void updateBranch(SomOrgan dataBean);
	/**
	 * 保存分支机构注销
	 * 
	 * @param dataBean
	 */
	@Trans
	public void saveBranchCancel(SomOrgan dataBean);
	
	/**
	 * 社会组织信息的查询操作
	 * 
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryOrgan(ParameterSet pset);

	/**
	 * 主体基本信息的查询操作
	 * 
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryMain(ParameterSet pset);

	/**
	 * 分支基本信息的查询操作
	 * 
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryBranch(ParameterSet pset);

	/**
	 * 成员信息的查询操作
	 * 
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryMember(ParameterSet pset);

	/**
	 * 人员基本信息的查询操作
	 * 
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryPeople(ParameterSet pset);
	
	/**
	 * sql查询人员基本信息
	 * @param pset
	 * @return
	 */
	public DataSet queryPeopleBySql(ParameterSet pset);
	
	/**
	 * 根据社会组织ID和人员类型或人员ID查询人员信息
	 * 
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryPeopleByParam(ParameterSet pset);
	
	/**
	 * 根据身份证号人员信息
	 * 
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryPeopleByIdCard(ParameterSet pset);

	/**
	 * 社会组织清算组织人员信息的查询操作
	 * @param pset
	 * @return
	 */
	public DataSet queryLiqpeople(ParameterSet pset);
	
	/**
	 * 查询主体对应的分支机构状态的数量
	 * @param mainMorgId
	 * @return
	 */
	public String branchStatusNum(String mainMorgId,String sorgStatus,String sorgStatus2);
	
	/**
	 * 查询登记证号是否重复
	 * @param sorgCode
	 * @return
	 */
	public String sorgCodeUK(String sorgCode);
	/**
	 * 查询社会组织名称是否重复
	 * @param cnName
	 * @return
	 */
	public String cnNameUK(String cnName);
	/**
	 * 查询社会组织机构代码是否重复
	 * @param cnName
	 * @return
	 */
	public String organCodeUK(String organCode);
	/**
	 * 查询负责人管理列表
	 */
	public DataSet queryPeopleList(ParameterSet pset);
	
	/**
	 * 查询分支机构的主体名称
	 */
	public String queryMainName(String sorgType, String sorgId);
	
	/**
	 * 根据人员ID查询Member表
	 */
	public DataSet queryMemberByPeopleId(ParameterSet pset);
	
//-----------------------------------jiangzhaobao-------------------------------------------------	
	/**
	 * 基金会换届选举的查询，保存和更新操作
	 */
	public DataSet queryElection(ParameterSet pset);
	@Trans
	public void insertElection(SomMeeting somMeeting,String meetingDate,Integer electionPeriod, String sorgId);
	@Trans
	public void updateElection(SomMeeting somMeeting,Integer electionPeriod);
	/**
	 * 基金会账户备案信息的查询，保存和更新操作
	 */
	public DataSet queryAccount(ParameterSet pset);
	@Trans
	public void insertAccount(SomAccount somAccount);
	@Trans
	public void updateAccount(SomAccount somAccount);
	/**
	 * 基金会的章程备案的查询，保存和更新操作
	 * @param pset
	 * @return
	 */
	public DataSet queryRule(ParameterSet pset);
	@Trans
	public void insertRule(SomMeeting somMeeting);
	@Trans
	public void updateRule(SomMeeting somMeeting);
	/**
	 * 基金会举办实体的查询，保存和更新操作
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryEntity(ParameterSet pset);

	@Trans
	public void insertEntity(SomEntity somEntity);

	@Trans
	public void updateEntity(SomEntity somEntity);

	/**
	 * 社会团体办事机构的查询,保存和更新操作
	 * 
	 */
	public DataSet queryOffice(ParameterSet pset);
	
	@Trans
	public void insertOffice(SomOffice somOffice);

	@Trans
	public void updateOffice(SomOffice somOffice);
	/**
	 * 根据银行账号查询社会组织
	 * @param pset
	 * @return社会组织ID串
	 */
	public String queryAccountForQuery(ParameterSet pset);
}
