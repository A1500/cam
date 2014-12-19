package com.inspur.cams.sorg.manage.cmd;

import java.util.List;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.data.SomLiqpeople;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomPeople;
import com.inspur.cams.sorg.manage.domain.ISomGroupDomain;

/**
 * 社团成立基本信息、人员信息的录入、修改和查看
 * 
 * @author muqi
 * @date 2011年5月26日13:58:38
 */
public class SomGroupCmd extends BaseAjaxCommand {
	private ISomGroupDomain service = ScaComponentFactory.getService(ISomGroupDomain.class, "somGroupDomain/somGroupDomain");
	//-------------------------------------------------------------------muqi------------------------------------------------------------------------------
	/**
	 * 保存社会组织和法定代表人信息
	 */
	@SuppressWarnings( { "unchecked", "unchecked" })
	public void saveMain() {
		// 获取前台社会组织信息
		SomOrgan organBean = (SomOrgan) getParameter("organBean");
		// 加载所有人员信息列表
		List<SomPeople> somPeopleList = (List<SomPeople>) getParameter("somPeopleList");
		organBean.setSomPeopleList(somPeopleList);
		// 获取组织种类
		String sorgType = (String) getParameter("sorgType");
		// 提交主体bean
		service.saveMain(organBean, sorgType);
	}

	/**
	 * 更新社会组织和法定代表人信息
	 */
	@SuppressWarnings( { "unchecked", "unchecked" })
	public void updateMain() {
		// 获取前台数据
		SomOrgan organBean = (SomOrgan) getParameter("organBean");
		List<SomPeople> somPeopleList = (List<SomPeople>) getParameter("somPeopleList");
		// 加载所有人员信息列表
		organBean.setSomPeopleList(somPeopleList);
		// 提交主体bean
		service.updateMain(organBean);
	}

	/**
	 * 保存负责人信息
	 */
	public void savePeople() {
		SomPeople peopleBean = (SomPeople) getParameter("peopleBean");
		service.savePeople(peopleBean);
	}

	/**
	 * 更新负责人信息
	 */
	public void updatePeople() {
		SomPeople peopleBean = (SomPeople) getParameter("peopleBean");
		service.updatePeople(peopleBean);
	}

	/**
	 * 注销负责人信息
	 */
	public void cancelPeople() {
		String sorgId = (String) getParameter("sorgId");
		String memberId = (String) getParameter("memberId");
		service.cancelPeople(sorgId, memberId);
	}

	/**
	 * 保存社会组织注销和清算人员信息
	 */
	@SuppressWarnings("unchecked")
	public void saveCancel() {
		// 获取前台社会组织信息
		SomOrgan organBean = (SomOrgan) getParameter("organBean");
		// 加载社会组织清算组织人员信息列表
		List<SomLiqpeople> somLiqpeopleList = (List<SomLiqpeople>) getParameter("somLiqpeopleList");
		organBean.setSomLiqpeopleList(somLiqpeopleList);
		// 提交主体bean
		service.saveCancel(organBean);
	}
	
	/**
	 * 保存社会组织的撤销操作
	 */
	public void saveRepeal(){
		String sorgId = (String) getParameter("sorgId");
		service.saveRepeal(sorgId);
	}

	/**
	 * 保存分支机构信息
	 */
	@SuppressWarnings( { "unchecked", "unchecked" })
	public void saveBranch() {
		// 获取前台社会组织信息
		SomOrgan organBean = (SomOrgan) getParameter("organBean");
		// 获取组织种类
		String sorgType = (String) getParameter("sorgType");
		// 提交主体bean
		service.saveBranch(organBean, sorgType);
	}

	/**
	 * 更新分支机构信息
	 */
	@SuppressWarnings("unchecked")
	public void updateBranch() {
		// 获取前台社会组织信息
		SomOrgan organBean = (SomOrgan) getParameter("organBean");
		// 提交主体bean
		service.updateBranch(organBean);

	}

	/**
	 * 保存分支机构注销
	 */
	public void saveBranchCancel() {
		// 获取前台社会组织信息
		SomOrgan organBean = (SomOrgan) getParameter("organBean");
		service.saveBranchCancel(organBean);
	}	
	
	
	/**
	 * 查询主体对应的分支机构是未被注销的数量
	 */
	public void branchIfCancel() {
		String mainMorgId = (String) getParameter("mainSorgId");
		setReturn("notCancelNum", service.branchIfCancel(mainMorgId));
	}
	/**
	 * 查询主体对应的分支机构是未被撤销的数量
	 */
	public void branchIfRepeal() {
		String mainMorgId = (String) getParameter("mainSorgId");
		setReturn("notRepealNum", service.branchIfRepeal(mainMorgId));
	}
	
	/**
	 * 查询社会组织ID是否重复
	 */
	public void sorgIdUK(){
		String sorgId = (String) getParameter("sorgId");
		setReturn("sorgIdNum",service.sorgIdUK(sorgId));
	}
	
	/**
	 * 查询登记证号是否重复
	 */
	public void sorgCodeUK() {
		String sorgCode = (String) getParameter("sorgCode");
		setReturn("sorgCodeNum", service.sorgCodeUK(sorgCode));
	}

	/**
	 * 查询社会组织名称是否重复
	 */
	public void cnNameUK() {
		String cnName = (String) getParameter("cnName");
		setReturn("cnNameNum", service.cnNameUK(cnName));
	}
	/**
	 * 查询社会组织机构代码是否重复
	 */
	public void organCodeUK() {
		String organCode = (String) getParameter("organCode");
		setReturn("organCodeNum", service.organCodeUK(organCode));
	}
	
	/**
	 * 查询分支机构的主体名称
	 */
	public void queryMainName() {
		String sorgType = (String) getParameter("sorgType");
		String sorgId = (String) getParameter("sorgId");
		String name = service.queryMainName(sorgType,sorgId);
		setReturn("name", name);
	}
	/**
	 * 查询主体对应的分支机构状态的数量
	 */
	public void branchStatusNum() {
		String mainMorgId = (String) getParameter("mainSorgId");
		String sorgStatus = (String) getParameter("sorgStatus");
		String sorgStatus2 = (String) getParameter("sorgStatus2");
		String sorgStatus3 = (String) getParameter("sorgStatus3");
		setReturn("num", service.branchStatusNum(mainMorgId, sorgStatus,sorgStatus2,sorgStatus3));
	}
	/**
	 * 根据sorgId，查询法人的政治面貌
	 */
	public void queryQolitics(){
		String sorgId = (String) getParameter("sorgId");
		setReturn("politics", service.queryQolitics(sorgId));
	}
	/**
	 * 人员综合查询中查询member表
	 * 2011年6月10日15:20:27
	 */
	public void queryMemberForP(){
		ParameterSet pset = getParameterSet();
		String idString=service.queryMemberForP(pset);
		setReturn("idString", idString);
	}
	
}