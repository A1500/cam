package com.inspur.cams.sorg.manage.domain.support;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.data.RecordSet;
import org.loushang.next.web.cmd.CommandContext;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.workflow.api.WfQueryDCwork;
import org.loushang.workflow.api.WfTaskRequestWrapper;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.data.SomAccount;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomCert;
import com.inspur.cams.sorg.base.data.SomDuty;
import com.inspur.cams.sorg.base.data.SomEntity;
import com.inspur.cams.sorg.base.data.SomFlow;
import com.inspur.cams.sorg.base.data.SomLiqpeople;
import com.inspur.cams.sorg.base.data.SomMeeting;
import com.inspur.cams.sorg.base.data.SomOffice;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomPeople;
import com.inspur.cams.sorg.base.domain.ISomAccountDomain;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomCertDomain;
import com.inspur.cams.sorg.base.domain.ISomDutyDomain;
import com.inspur.cams.sorg.base.domain.ISomEntityDomain;
import com.inspur.cams.sorg.base.domain.ISomFlowDomain;
import com.inspur.cams.sorg.base.domain.ISomLiqpeopleDomain;
import com.inspur.cams.sorg.base.domain.ISomMeetingDomain;
import com.inspur.cams.sorg.base.domain.ISomOfficeDomain;
import com.inspur.cams.sorg.base.domain.ISomOrganDomain;
import com.inspur.cams.sorg.base.domain.ISomPeopleDomain;
import com.inspur.cams.sorg.manage.domain.ISomGroupDomain;
import com.inspur.cams.sorg.util.Activity;

/**
 * 社团业务domain
 * 
 * @author muqi
 * @date 2011年6月2日9:35:12
 */
public class SomGroupDomain implements ISomGroupDomain {
	@Reference
	private ISomFlowDomain somFlowDomain;
	@Reference
	private ISomApplyDomain somApplyDomain;
	@Reference
	private ISomCertDomain somCertDomain;
	@Reference
	private ISomOrganDomain somOrganDomain;
	@Reference
	private ISomPeopleDomain somPeopleDomain;
	@Reference
	private ISomDutyDomain somDutyDomain;
	@Reference
	private ISomLiqpeopleDomain somLiqpeopleDomain;
	// 备案
	@Reference
	private ISomAccountDomain somAccountDomain;
	@Reference
	private ISomEntityDomain somEntityDomain;
	@Reference
	private ISomMeetingDomain somMeetingDomain;
	@Reference
	private ISomOfficeDomain somOfficeDomain;


	// ------------------------------------muqi-------------------------------------------------
	/**
	 * 创建社会组织信息
	 */
	private void createOrgan(SomOrgan organBean, String ifBranch,String sorgType) {
		// set基本信息
		organBean.setSorgStatus("22");
		organBean.setSorgType(sorgType);
		organBean.setIfBranch(ifBranch);
		organBean.setMorgName(BspUtil.getCorpOrgan().getOrganName());
		organBean.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
	}

	/**
	 * 更新社会组织信息
	 */
	private void updateOrgan(SomOrgan organBean, String sorgStatus) {
		// set基本信息
		organBean.setSorgId(organBean.getSorgId());
		organBean.setSorgStatus(sorgStatus);
	}

	/**
	 * set相应的组织成员表信息
	 * 
	 * @param currentSorgId
	 * @param currentPeopleId
	 * @param organBean
	 * @param peopleBean
	 * @return
	 */
	private void setMember(SomDuty memberBean, SomPeople peopleBean,
			SomOrgan organBean, String currentSorgId, String peopleType) {
		memberBean.setSorgId(currentSorgId);
		memberBean.setPeopleId(peopleBean.getPeopleId());
		memberBean.setSorgName(organBean.getCnName());
		memberBean.setSorgKind(organBean.getSorgKind());
		memberBean.setSorgType(organBean.getSorgType());
		memberBean.setPeopleName(peopleBean.getName());
		memberBean.setPeopleType(peopleType);
		memberBean.setSorgDuties(peopleBean.getSorgDuties());
		memberBean.setOtherDuties(peopleBean.getOtherDuties());
		memberBean.setWorkOpinion(peopleBean.getWorkOpinion());
		memberBean.setWorkCheckDate(peopleBean.getWorkCheckDate());
		memberBean.setSorgOpinion(peopleBean.getSorgOpinion());
		memberBean.setSorgCheckDate(peopleBean.getSorgCheckDate());
		memberBean.setIfPartyLeader(peopleBean.getIfPartyLeader());
		memberBean.setPromiseOrgan(peopleBean.getPromiseOrgan());
		memberBean.setPromiseCode(peopleBean.getPromiseCode());
		memberBean.setIfRedo(peopleBean.getIfRedo());
		memberBean.setIfValid("2");
		memberBean.setNote(peopleBean.getMemberNote());
		memberBean.setMorgName(BspUtil.getCorpOrgan().getOrganName());
		memberBean.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
		memberBean.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
		memberBean.setCreateTime(DateUtil.getTime());
	}

	/**
	 * se更新相应的组织成员表信息
	 * 
	 * @param currentSorgId
	 * @param currentPeopleId
	 * @param organBean
	 * @param peopleBean
	 * @return
	 */
	private void updateMember(SomDuty memberBean, SomPeople peopleBean,
			SomOrgan organBean, String currentSorgId, String peopleType) {
		memberBean.setSorgId(currentSorgId);
		memberBean.setPeopleId(peopleBean.getPeopleId());
		memberBean.setSorgName(organBean.getCnName());
		memberBean.setSorgKind(organBean.getSorgKind());
		memberBean.setSorgType(organBean.getSorgType());
		memberBean.setPeopleName(peopleBean.getName());
		memberBean.setPeopleType(peopleType);
		memberBean.setSorgDuties(peopleBean.getSorgDuties());
		memberBean.setOtherDuties(peopleBean.getOtherDuties());
		memberBean.setWorkOpinion(peopleBean.getWorkOpinion());
		memberBean.setWorkCheckDate(peopleBean.getWorkCheckDate());
		memberBean.setSorgOpinion(peopleBean.getSorgOpinion());
		memberBean.setSorgCheckDate(peopleBean.getSorgCheckDate());
		memberBean.setIfPartyLeader(peopleBean.getIfPartyLeader());
		memberBean.setPromiseOrgan(peopleBean.getPromiseOrgan());
		memberBean.setPromiseCode(peopleBean.getPromiseCode());
		memberBean.setIfRedo(peopleBean.getIfRedo());
		memberBean.setIfValid("2");
		memberBean.setNote(peopleBean.getMemberNote());
		memberBean.setMorgName(BspUtil.getCorpOrgan().getOrganName());
		memberBean.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
		memberBean.setModPeople(BspUtil.getEmpOrgan().getOrganName());
		memberBean.setModTime(DateUtil.getTime());
	}

	/**
	 * 设置人员为无效
	 */
	private void setNoValid(String currentSorgId,String memberId) {
		ParameterSet pset = new ParameterSet();
		if(memberId != null){
			pset.setParameter("ID@=", memberId);
		}else{
			pset.setParameter("SORG_ID@=", currentSorgId);
			pset.setParameter("PEOPLE_TYPE@=", "L");
			pset.setParameter("IF_VALID", "2");
		}
		DataSet ds = queryMember(pset);
		if (ds.getCount() == 1) {
			SomDuty memberBean = (SomDuty) ds.getRecord(0).toBean(
					SomDuty.class);
			memberBean.setIfValid("0");
			memberBean.setModPeople(BspUtil.getEmpOrgan().getOrganName());
			memberBean.setModTime(DateUtil.getTime());
			somDutyDomain.update(memberBean);
		} else {
			System.out.println("error:设置人员无效");
		}
	}

	/**
	 * 注销组织机构的所有人员
	 */
	private void setAllNoValid(String currentSorgId,String sorgStatus) {
		List<SomDuty> memberList = new ArrayList<SomDuty>();
		ParameterSet memberPset = new ParameterSet();
		memberPset.setParameter("SORG_ID@=", currentSorgId);
		String valid = "";
		if(sorgStatus.equals("32")){
			valid = "3";
			memberPset.setParameter("IF_VALID@in", "2");
		}else if(sorgStatus.equals("52")){
			valid = "4";
			memberPset.setParameter("IF_VALID@in", "2");
		}else if(sorgStatus.equals("62")){
			valid = "5";
			memberPset.setParameter("IF_VALID@in", "4");
		}
		DataSet memberDs = queryMember(memberPset);
		for (int i = 0; i < memberDs.getCount(); i++) {
			SomDuty memberBean = (SomDuty) memberDs.getRecord(i).toBean(SomMember.class);
			memberBean.setIfValid(valid);
			memberBean.setModPeople(BspUtil.getEmpOrgan().getOrganName());
			memberBean.setModTime(DateUtil.getTime());
			memberList.add(memberBean);
		}
		somDutyDomain.batchUpdate(memberList);
	}
	/**
	 * 人员复用时，修改此人信息和对应som_member表的所有名字
	 * 
	 * @param peopleBean
	 * @param somMemberList
	 */
	private void updatePeopleName(SomPeople peopleBean) {
		List<SomDuty> somMemberList = new ArrayList<SomDuty>();
		ParameterSet pset = new ParameterSet();
		pset.setParameter("PEOPLE_ID@=", peopleBean.getPeopleId());
		DataSet ds = queryMember(pset);
		for (int i = 0; i < ds.getCount(); i++) {
			SomDuty memberBean = (SomDuty) ds.getRecord(i).toBean(
					SomDuty.class);
			memberBean.setPeopleName(peopleBean.getName());
			somMemberList.add(memberBean);
		}
		somDutyDomain.batchUpdate(somMemberList);
	}

	/**
	 * 人员复用时，修改此人担任法定代表人，则修改对应社团中legPeople信息
	 * 
	 * @param peopleBean
	 * @param somMemberList
	 */
	private void updateLegPeople(SomPeople peopleBean) {
		List<SomOrgan> somOrganList = new ArrayList<SomOrgan>();
		ParameterSet pset = new ParameterSet();
		pset.setParameter("PEOPLE_ID@=", peopleBean.getPeopleId());
		pset.setParameter("PEOPLE_TYPE@=", "L");
		DataSet ds = queryMember(pset);
		for (int i = 0; i < ds.getCount(); i++) {
			String id = (String) ds.getRecord(i).get("sorgId");
			pset.clear();
			pset.setParameter("SORG_ID@=", id);
			SomOrgan organBean = (SomOrgan) queryMain(pset).getRecord(0)
					.toBean(SomOrgan.class);
			organBean.setLegalPeople(peopleBean.getName());
			somOrganList.add(organBean);
			pset.clear();
			pset.setParameter("MAIN_SORG_ID@=", id);
			DataSet dset = queryBranch(pset);
			for (int j = 0; j < dset.getCount(); j++) {
				SomOrgan organ = (SomOrgan) dset.getRecord(j).toBean(
						SomOrgan.class);
				organ.setLegalPeople(peopleBean.getName());
				somOrganList.add(organ);
			}
			somOrganDomain.batchUpdate(somOrganList);

		}
	}

	/**
	 * 保存社会组织和法定代表人信息
	 * 
	 * @param dataBean
	 */
	public void saveMain(SomOrgan organBean, String sorgType) {
		// set社会组织信息
		String currentSorgId = organBean.getSorgId();
		createOrgan(organBean, "0", sorgType);
		// set法定代表人
		List<SomPeople> somPeopleList = organBean.getSomPeopleList();
		if (somPeopleList.size() == 1) {
			// 得到法定代表人Bean
			SomPeople peopleBean = somPeopleList.get(0);
			// 保存社会组织法定代表人
			somOrganDomain.insert(organBean);
			// 判断人员是否复用
			String currentPeopleId = peopleBean.getPeopleId();
			if (currentPeopleId != null) {
				// 人员复用则使用原人员信息
				updatePeopleName(peopleBean);
				// 更新社会组织法定代表人
				updateLegPeople(peopleBean);
				// 更新人员
				somPeopleDomain.update(peopleBean);
			} else {
				// 人员新建则创建新的人员ID
				peopleBean.setPeopleId(IdHelp.getUUID30());
				peopleBean.setCardType("01");
				peopleBean.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
				peopleBean.setCreateTime(DateUtil.getTime());
				// 保存人员
				somPeopleDomain.insert(peopleBean);
			}
			// set相应的组织成员表信息
			SomDuty memberBean = new SomDuty();
			memberBean.setId(IdHelp.getUUID30());
			setMember(memberBean, peopleBean, organBean, currentSorgId, "L");
			somDutyDomain.insert(memberBean);
		} else {
			System.out.println("error:保存法定代表人");
		}
	}

	/**
	 * 更新社会组织和法定代表人信息
	 * 
	 * @param dataBean
	 */
	public void updateMain(SomOrgan organBean) {

		String currentSorgId = organBean.getSorgId();
		// 判断社团信息是否做过修改
		if (organBean.getState() == Record.STATE_MODIFIED) {
			// 更新社团信息
			updateOrgan(organBean, "22");
			somOrganDomain.update(organBean);
			// 更新成员信息
			List<SomDuty> somMemberList = new ArrayList<SomDuty>();
			ParameterSet pset = new ParameterSet();
			pset.setParameter("SORG_ID@=", currentSorgId);
			DataSet ds = queryMember(pset);
			for (int i = 0; i < ds.getCount(); i++) {
				// 如果基本信息修改，则成员表相关信息也做修改
				SomDuty memberBean = (SomDuty) queryMember(pset).getRecord(
						i).toBean(SomDuty.class);
				memberBean.setSorgName(organBean.getCnName());
				memberBean.setSorgKind(organBean.getSorgKind());
				memberBean.setModPeople(BspUtil.getEmpOrgan().getOrganName());
				memberBean.setModTime(DateUtil.getTime());
				somMemberList.add(memberBean);
			}
			somDutyDomain.batchUpdate(somMemberList);
		}
		List<SomPeople> somPeopleList = organBean.getSomPeopleList();
		// 得到法定代表人Bean
		if (somPeopleList.size() == 1) {
			SomPeople peopleBean = somPeopleList.get(0);
			// 获得当前人员ID
			String currentPeopleId = peopleBean.getPeopleId();
			// 如果人员信息是新建的
			if (currentPeopleId == null) {
				peopleBean.setPeopleId(IdHelp.getUUID30());
				peopleBean.setCardType("01");
				peopleBean.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
				peopleBean.setCreateTime(DateUtil.getTime());
				somPeopleDomain.insert(peopleBean);
				// 把原法定代表人设置成无效
				setNoValid(currentSorgId,null);
				// 新建成员关系
				SomDuty memberBean = new SomDuty();
				memberBean.setId(IdHelp.getUUID30());
				setMember(memberBean, peopleBean, organBean, currentSorgId, "L");
				somDutyDomain.insert(memberBean);
			} else {
				// 如果人员信息是回填的
				ParameterSet pset = new ParameterSet();
				pset.setParameter("PEOPLE_ID@=", currentPeopleId);
				pset.setParameter("SORG_ID@=", currentSorgId);
				pset.setParameter("PEOPLE_TYPE@=", "L");
				pset.setParameter("IF_VALID@=", "2");
				DataSet ds = queryMember(pset);
				// 如果更换法定代表人
				if (ds.getCount() == 0) {
					// 把原法定代表人设置成无效
					setNoValid(currentSorgId,null);
					// 更新成员信息
					updatePeopleName(peopleBean);
					// 更新人员信息
					somPeopleDomain.update(peopleBean);
					// 新建成员信息
					SomDuty memberBean = new SomDuty();
					memberBean.setId(IdHelp.getUUID30());
					setMember(memberBean, peopleBean, organBean, currentSorgId,"L");
					somDutyDomain.insert(memberBean);
				}
				// 如果只修改原法定代表人的信息，不换人
				if (ds.getCount() == 1) {
					// 更新成员信息
					updatePeopleName(peopleBean);
					// 更新人员信息
					peopleBean.setModPeople(BspUtil.getEmpOrgan().getOrganName());
					peopleBean.setModTime(DateUtil.getTime());
					somPeopleDomain.update(peopleBean);
					// 更新成员信息
					SomDuty memberBean = (SomDuty) ds.getRecord(0).toBean(
							SomDuty.class);
					updateMember(memberBean, peopleBean, organBean,currentSorgId, "L");
					somDutyDomain.update(memberBean);
				}
			}
			// 更新社团基本信息表中的法定代表人
			updateLegPeople(peopleBean);
		} else {
			System.out.println("error:修改法定代表人");
		}
	}

	/**
	 * 保存负责人信息
	 */
	public void savePeople(SomPeople peopleBean) {
		String sorgId = peopleBean.getSorgId();
		String peopleId = peopleBean.getPeopleId();
		String peopleType = peopleBean.getPeopleType();
		// 更新社会组织
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID@=", sorgId);
		SomOrgan organBean = (SomOrgan) queryOrgan(pset).getRecord(0).toBean(SomOrgan.class);
		updateOrgan(organBean, "22");
		somOrganDomain.update(organBean);
		// 新建人员
		if (peopleId == null) {
			// 保存人员信息
			peopleBean.setPeopleId(IdHelp.getUUID30());
			peopleBean.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
			peopleBean.setCreateTime(DateUtil.getTime());
			somPeopleDomain.insert(peopleBean);
		} else {
			// 更新社团信息
			updateLegPeople(peopleBean);
			// 更新成员信息
			updatePeopleName(peopleBean);
			// 更新人员信息
			somPeopleDomain.update(peopleBean);
		}
		// 保存成员信息
		SomDuty memberBean = new SomDuty();
		memberBean.setId(IdHelp.getUUID30());
		setMember(memberBean, peopleBean, organBean, sorgId, peopleType);
		somDutyDomain.insert(memberBean);
	}

	/**
	 * 更新负责人信息
	 * 
	 * @param sorgId
	 * @param dataBean
	 */
	public void updatePeople(SomPeople peopleBean) {
		// 更新社团信息
		String sorgId = peopleBean.getSorgId();
		String memberId = peopleBean.getId();
		String peopleType = peopleBean.getPeopleType();
		ParameterSet p = new ParameterSet();
		p.setParameter("SORG_ID@=", sorgId);
		SomOrgan organBean = (SomOrgan) queryOrgan(p).getRecord(0).toBean(SomOrgan.class);
		updateOrgan(organBean, "22");
		somOrganDomain.update(organBean);
		updateLegPeople(peopleBean);
		// 更新成员信息
		updatePeopleName(peopleBean);
		// 更新人员
		peopleBean.setModPeople(BspUtil.getEmpOrgan().getOrganName());
		peopleBean.setModTime(DateUtil.getTime());
		somPeopleDomain.update(peopleBean);
		// 更新成员信息
		ParameterSet pset = new ParameterSet();
		pset.setParameter("ID@=", memberId);
		DataSet ds = queryMember(pset);
		if (ds.getCount() == 1) {
			SomDuty memberBean = (SomDuty) ds.getRecord(0).toBean(SomDuty.class);
			updateMember(memberBean, peopleBean, organBean, sorgId, peopleType);
			somDutyDomain.update(memberBean);
		} else {
			System.out.println("error:更新负责人成员");
		}
	}

	/**
	 * 注销负责人信息
	 * 
	 * @param peopleId
	 * @param sorgId
	 */
	public void cancelPeople(String sorgId, String memberId) {
		// 更新社团信息
		ParameterSet p = new ParameterSet();
		p.setParameter("SORG_ID@=", sorgId);
		SomOrgan organBean = (SomOrgan) queryOrgan(p).getRecord(0).toBean(SomOrgan.class);
		updateOrgan(organBean, "22");
		somOrganDomain.update(organBean);
		setNoValid(null,memberId);
	}

	/**
	 * 保存社会组织注销和清算人员信息
	 */
	public void saveCancel(SomOrgan organBean) {
		String sorgId = organBean.getSorgId();
		if (organBean.getState() == Record.STATE_MODIFIED) {
			// set基本信息
			String sorgStatus = organBean.getSorgStatus();
			String _sorgStatus = "";
			if(sorgStatus.equals("52") || sorgStatus.equals("62")){
				_sorgStatus = "62";
			}else{
				_sorgStatus = "32";
			}
			updateOrgan(organBean, _sorgStatus);
			// 更新社会组织的基本信息
			somOrganDomain.update(organBean);
			// 注销组织的所有会议和人员
			setAllNoValid(sorgId,_sorgStatus);
		}
		// 保存社会组织清算组织人员信息
		List<SomLiqpeople> somLiqpeopleList = organBean.getSomLiqpeopleList();
		if (somLiqpeopleList != null && somLiqpeopleList.size() > 0) {
			for (int i = 0; i < somLiqpeopleList.size(); i++) {
				SomLiqpeople liqpeopleBean = somLiqpeopleList.get(i);
				String currentId = liqpeopleBean.getId();
				if (currentId == null) {
					liqpeopleBean.setSorgId(sorgId);
					liqpeopleBean.setId(IdHelp.getUUID30());
					liqpeopleBean.setState(Record.STATE_NEW);
				} else {
					liqpeopleBean.setState(Record.STATE_DELETED);
				}
			}
			// 保存社会组织清算组织人员信息
			somLiqpeopleDomain.save(somLiqpeopleList);
		}
	}

	/**
	 * 保存社会组织的撤销操作
	 */
	public void saveRepeal(String sorgId){
		// set基本信息
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID@=", sorgId);
		SomOrgan organBean = (SomOrgan) queryOrgan(pset).getRecord(0).toBean(SomOrgan.class);
		updateOrgan(organBean, "52");
		// 更新社会组织的基本信息
		somOrganDomain.update(organBean);
		// 撤销组织的所有会议和人员
		setAllNoValid(sorgId,"52");
	}
	/**
	 * 保存分支机构信息
	 */
	public void saveBranch(SomOrgan organBean, String sorgType) {
		// 保存分支基本信息
		createOrgan(organBean, "1", sorgType);
		somOrganDomain.insert(organBean);
	}

	/**
	 * 更新分支机构信息
	 */
	public void updateBranch(SomOrgan organBean) {
		String branchSorgId = organBean.getSorgId();
		// 判断社团信息是否做过修改
		if (organBean.getState() == Record.STATE_MODIFIED) {
			// 更新社团信息
			updateOrgan(organBean, "22");
			somOrganDomain.update(organBean);
			// 更新成员信息
			List<SomDuty> somMemberList = new ArrayList<SomDuty>();
			ParameterSet pset = new ParameterSet();
			pset.setParameter("SORG_ID@=", branchSorgId);
			DataSet ds = queryMember(pset);
			for (int i = 0; i < ds.getCount(); i++) {
				// 如果基本信息修改，则成员表相关信息也做修改
				SomDuty memberBean = (SomDuty) queryMember(pset).getRecord(i).toBean(SomDuty.class);
				memberBean.setSorgKind(organBean.getSorgKind());
				memberBean.setSorgName(organBean.getCnName());
				memberBean.setModPeople(BspUtil.getEmpOrgan().getOrganName());
				memberBean.setModTime(DateUtil.getTime());
				somMemberList.add(memberBean);
			}
			somDutyDomain.batchUpdate(somMemberList);
		}
	}

	/**
	 * 保存分支机构注销
	 */
	public void saveBranchCancel(SomOrgan organBean) {
		String sorgId = organBean.getSorgId();
		if (organBean.getState() == Record.STATE_MODIFIED) {
			// set基本信息
			String sorgStatus = organBean.getSorgStatus();
			String _sorgStatus = "";
			if(sorgStatus.equals("52") || sorgStatus.equals("62")){
				_sorgStatus = "62";
			}else{
				_sorgStatus = "32";
			}
			updateOrgan(organBean, _sorgStatus);
			// 更新社会组织的基本信息
			somOrganDomain.update(organBean);
			// 注销组织的所有会议和人员
			setAllNoValid(sorgId,_sorgStatus);
		}
	}

	/**
	 * 社会团体换届（成立）选举报告的查询，保存和更新操作
	 */
	public DataSet queryElection(ParameterSet pset){
		pset.setParameter("MEETING_TYPE", "X");
		pset.setParameter("SORG_TYPE", "S");
		if(pset.containsKey("cnName")){
			String cnName = (String) pset.getParameter("cnName");
			ParameterSet p = new ParameterSet();
			p.setParameter("CN_NAME@=", cnName);
			DataSet ds = queryOrgan(p);
			if(ds.getCount() == 1){
				pset.put("SORG_ID@=", (String)ds.getRecord(0).get("sorgId"));
			}else{
				if(cnName.trim().equals("")){
					pset.put("SORG_ID@=", "");
				}else {
					pset.put("SORG_ID@=", "null");
				}
			}
			pset.remove("cnName");
		}
		return somMeetingDomain.query(pset);
	}
	
	public void insertElection(SomMeeting somMeeting,String meetingDate,Integer electionPeriod, String sorgId) {
		String currentId =IdHelp.getUUID30();	
		String morgName=BspUtil.getCorpOrgan().getOrganName();
		String morgArea=BspUtil.getCorpOrgan().getOrganCode();
		somMeeting.setId(currentId);
		somMeeting.setMorgName(morgName);
		somMeeting.setMorgArea(morgArea);				
		ParameterSet pset=new ParameterSet();
		pset.setParameter("SORG_ID@=", somMeeting.getSorgId());
		pset.setParameter("MEETING_TYPE@=", "X");
		pset.setParameter("IF_CURRENT@=", "1");
		if(somMeetingDomain.query(pset).getCount()==0){
			somMeeting.setMeetingType("X");
			somMeetingDomain.insert(somMeeting);
			somOrganDomain.updateElectionDate(sorgId, meetingDate, electionPeriod);
		}else{
			SomMeeting updateMeeting=(SomMeeting)somMeetingDomain.query(pset).getRecord(0).toBean(SomMeeting.class);
			somMeeting.setMeetingType("X");
			somMeetingDomain.insert(somMeeting);
			
			somMeetingDomain.update(updateMeeting);
			somOrganDomain.updateElectionDate(sorgId, meetingDate, electionPeriod);
		}
		
	}
	public void updateElection(SomMeeting somMeeting,Integer electionPeriod ) {
		somOrganDomain.updateElectionDate(somMeeting.getSorgId(), somMeeting.getMeetingDate(), electionPeriod);
		somMeetingDomain.update(somMeeting);
	}
	/**
	 * 社团账户备案信息的查询，保存和更新操作
	 */
	public DataSet queryAccount(ParameterSet pset) {
		pset.setParameter("SORG_TYPE@=", "S");
		if(pset.containsKey("cnName")){
			String cnName = (String) pset.getParameter("cnName");
			ParameterSet p = new ParameterSet();
			p.setParameter("CN_NAME@=", cnName);
			DataSet ds = queryOrgan(p);
			if(ds.getCount() == 1){
				pset.put("SORG_ID@=", (String)ds.getRecord(0).get("sorgId"));
			}else{
				if(cnName.trim().equals("")){
					pset.put("SORG_ID@=", "");
				}else {
					pset.put("SORG_ID@=", "null");
				}
			}
			pset.remove("cnName");
		}
		return somAccountDomain.query(pset);
	}
	
	public void insertAccount(SomAccount somAccount) {
		String currentId =IdHelp.getUUID30();	
		String morgName=BspUtil.getCorpOrgan().getOrganName();
		String morgArea=BspUtil.getCorpOrgan().getOrganCode();
		somAccount.setId(currentId);
		somAccount.setMorgName(morgName);
		somAccount.setMorgArea(morgArea);
		somAccountDomain.insert(somAccount);
	}

	public void updateAccount(SomAccount somAccount) {
		somAccountDomain.update(somAccount);
	}
	
	/**
	 * 社会团体的会费标准备案的保存和更新操作
	 */
	public void insertFee(SomMeeting somMeeting) {
		String currentId =IdHelp.getUUID30();	
		String morgName=BspUtil.getCorpOrgan().getOrganName();
		String morgArea=BspUtil.getCorpOrgan().getOrganCode();
		somMeeting.setId(currentId);
		somMeeting.setMorgName(morgName);
		somMeeting.setMorgArea(morgArea);
		ParameterSet pset=new ParameterSet();
		pset.setParameter("SORG_ID@=", somMeeting.getSorgId());
		pset.setParameter("MEETING_TYPE@=", "F");
		pset.setParameter("IF_CURRENT@=", "1");	
		if(somMeetingDomain.query(pset).getCount()==0){
			somMeeting.setMeetingType("F");
			somMeetingDomain.insert(somMeeting);
			
		}else{
			SomMeeting updateMeeting=(SomMeeting)somMeetingDomain.query(pset).getRecord(0).toBean(SomMeeting.class);
			somMeeting.setMeetingType("F");
			somMeetingDomain.insert(somMeeting);
			somMeetingDomain.update(updateMeeting);
		}
	}
	
	public void updateFee(SomMeeting somMeeting) {
		somMeetingDomain.update(somMeeting);
	}
	
	/**
	 * 社会团体的章程备案保存和更新操作
	 */
	public void insertRule(SomMeeting somMeeting) {
		String currentId =IdHelp.getUUID30();	
		String morgName=BspUtil.getCorpOrgan().getOrganName();
		String morgArea=BspUtil.getCorpOrgan().getOrganCode();
		somMeeting.setId(currentId);
		somMeeting.setMorgName(morgName);
		somMeeting.setMorgArea(morgArea);				
		ParameterSet pset=new ParameterSet();
		pset.setParameter("SORG_ID@=", somMeeting.getSorgId());
		pset.setParameter("MEETING_TYPE@=", "Z");
		pset.setParameter("IF_CURRENT@=", "1");
		if(somMeetingDomain.query(pset).getCount()==0){
			
			somMeeting.setMeetingType("Z");
	//		somMeeting.setSorgType("S");
			somMeetingDomain.insert(somMeeting);
		}else{
		SomMeeting updateMeeting=(SomMeeting)somMeetingDomain.query(pset).getRecord(0).toBean(SomMeeting.class);
		somMeeting.setMeetingType("Z");
//			somMeeting.setSorgType("S");
		somMeetingDomain.insert(somMeeting);
		
		somMeetingDomain.update(updateMeeting);
		}
		
	}
	public void updateRule(SomMeeting somMeeting) {
		somMeetingDomain.update(somMeeting);
		
	}
	/**
	 * 社会团体举办实体的查询，保存和更新操作
	 * @param pset
	 * @return
	 */
	public DataSet queryEntity(ParameterSet pset) {
		if(pset.containsKey("cnName")){
			String cnName = (String) pset.getParameter("cnName");
			ParameterSet p = new ParameterSet();
			p.setParameter("CN_NAME@=", cnName);
			DataSet ds = queryOrgan(p);
			if(ds.getCount() == 1){
				pset.put("SORG_ID@=", (String)ds.getRecord(0).get("sorgId"));
			}else{
				if(cnName.trim().equals("")){
					pset.put("SORG_ID@=", "");
				}else {
					pset.put("SORG_ID@=", "null");
				}
			}
			pset.remove("cnName");
		}
		return somEntityDomain.query(pset);
	}
	
	public void insertEntity(SomEntity somEntity) {
		String currentId =IdHelp.getUUID30();	
		String morgName=BspUtil.getCorpOrgan().getOrganName();
		String morgArea=BspUtil.getCorpOrgan().getOrganCode();
		somEntity.setId(currentId);
		somEntity.setMorgName(morgName);
		somEntity.setMorgArea(morgArea);		
		somEntityDomain.insert(somEntity);
	}
	
	public void updateEntity(SomEntity somEntity) {
		somEntityDomain.update(somEntity);
	}
	
	/**
	 * 社会团体办事机构保存和更新操作
	 */
	public void insertOffice(SomOffice somOffice) {
		String currentId =IdHelp.getUUID30();	
		String morgName=BspUtil.getCorpOrgan().getOrganName();
		String morgArea=BspUtil.getCorpOrgan().getOrganCode();
		somOffice.setId(currentId);
		somOffice.setMorgName(morgName);
		somOffice.setMorgArea(morgArea);		
		somOfficeDomain.insert(somOffice);
	}
	
	public void updateOffice(SomOffice somOffice) {
		somOfficeDomain.update(somOffice);		
	}


	/**
	 * 社会组织的查询操作
	 * 
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryOrgan(ParameterSet pset) {
		return somOrganDomain.query(pset);
	}

	/**
	 * 主体基本信息的查询操作
	 * 
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryMain(ParameterSet pset) {
		pset.setParameter("IF_BRANCH@=", "0");
		return queryOrgan(pset);
	}

	/**
	 * 分支基本信息的查询操作
	 * 
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryBranch(ParameterSet pset) {
		pset.setParameter("IF_BRANCH@=", "1");
		DataSet ds = queryOrgan(pset);
		if (ds.getCount() > 0) {
			for (int i = 0; i < ds.getCount(); i++) {
				Record record = ds.getRecord(i);
				ParameterSet p = new ParameterSet();
				p.setParameter("SORG_ID@=", record.get("mainSorgId"));
				record.set("name", queryMain(p).getRecord(0).get("cnName"));
			}
		}
		return ds;
	}

	/**
	 * 成员信息的查询操作
	 * 
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryMember(ParameterSet pset) {
		DataSet ds = somDutyDomain.query(pset);
		return ds;
	}

	/**
	 * 人员基本信息的查询操作
	 * 
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryPeople(ParameterSet pset) {
		DataSet ds = somPeopleDomain.query(pset);
		return ds;
	}

	/**
	 * sql查询人员基本信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryPeopleBySql(ParameterSet pset) {
		DataSet ds = somPeopleDomain.queryBySql(pset);
		return ds;
	}

	/**
	 * 根据社会组织ID和人员类型或人员ID查询人员信息
	 * 
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryPeopleByParam(ParameterSet pset) {
		if (pset.getParameter("SORG_ID@=") != null) {
			return queryPeopleBySql(pset);
		} else {
			return queryPeople(pset);
		}
	}

	/**
	 * 根据身份证号查询人员信息
	 */
	public DataSet queryPeopleByIdCard(ParameterSet pset) {
		DataSet peopleDs = queryPeople(pset);
		for (int i = 0; i < peopleDs.getCount(); i++) {
			Record peopleR = peopleDs.getRecord(i);
			String peopleId = (String) peopleR.get("peopleId");
			int count = somDutyDomain.queryLegalPeople(peopleId, null);
			String isLegal = "0";
			if (count > 0) {
				isLegal = "1";
			}
			peopleR.set("isLegal", isLegal);
			int num = somDutyDomain.queryRevokePeople(peopleId);
			String isRevoke = "0";
			if (num >0){
				isRevoke = "1";
			}
			peopleR.set("isRevoke", isRevoke);
		}
		return peopleDs;

	}

	/**
	 * 社会组织清算组织人员信息的查询操作
	 */
	public DataSet queryLiqpeople(ParameterSet pset) {
		DataSet ds = somLiqpeopleDomain.query(pset);
		return ds;
	}

	/**
	 * 查询主体对应的分支机构是未被注销的数量
	 */
	public String branchIfCancel(String mainMorgId) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("MAIN_SORG_ID@=", mainMorgId);
		DataSet ds = somOrganDomain.query(pset);
		int num = 0;
		for (int i = 0; i < ds.getCount(); i++) {
			if (ds.getRecord(i).get("sorgStatus").equals("22")) {
				num++;
			}
		}
		return ("" + num);
	}

	/**
	 * 查询主体对应的分支机构是未被撤销的数量
	 */
	public String branchIfRepeal(String mainMorgId) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("MAIN_SORG_ID@=", mainMorgId);
		DataSet ds = somOrganDomain.query(pset);
		int num = 0;
		for (int i = 0; i < ds.getCount(); i++) {
			if (ds.getRecord(i).get("sorgStatus").equals("22")) {
				num++;
			}
		}
		return ("" + num);
	}
	/**
	 * 查询社会组织ID是否重复
	 */
	public String sorgIdUK(String sorgId){
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID@=", sorgId);
		return ("" + queryOrgan(pset).getCount());
	}
	/**
	 * 查询登记证号是否重复
	 */
	public String sorgCodeUK(String sorgCode) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_CODE@=", sorgCode);
		return ("" + queryOrgan(pset).getCount());
	}

	/**
	 * 查询社会组织名称是否重复
	 */
	public String cnNameUK(String cnName) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("CN_NAME@=", cnName);
		return ("" + queryOrgan(pset).getCount());
	}

	/**
	 * 查询社会组织机构代码是否重复
	 */
	public String organCodeUK(String organCode) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("ORGAN_CODE@=", organCode);
		return ("" + queryOrgan(pset).getCount());
	}

	/**
	 * 查询负责人管理列表
	 */
	public DataSet queryPeopleList(ParameterSet pset) {
		return somPeopleDomain.queryPeopleList(pset);
	}

	/**
	 * 查询分支机构的主体名称
	 */
	public String queryMainName(String sorgType, String sorgId) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_TYPE@=", sorgType);
		pset.setParameter("SORG_ID@=", sorgId);
		return (String) somOrganDomain.query(pset).getRecord(0).get("cnName");
	}

	/**
	 * 根据人员ID查询Member表
	 */
	public DataSet queryMemberByPeopleId(ParameterSet pset) {
		return somMemberDomain.query(pset);
	}

	/**
	 * 查询主体对应的分支机构状态的数量
	 */
	public String branchStatusNum(String mainMorgId, String sorgStatus,
			String sorgStatus2, String sorgStatus3) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("MAIN_SORG_ID@=", mainMorgId);
		DataSet ds = somOrganDomain.query(pset);
		int num = 0;
		for (int i = 0; i < ds.getCount(); i++) {
			if (ds.getRecord(i).get("sorgStatus").equals(sorgStatus)) {
				num++;
			}
		}
		if (sorgStatus2 != null) {
			for (int i = 0; i < ds.getCount(); i++) {
				if (ds.getRecord(i).get("sorgStatus").equals(sorgStatus2)) {
					num++;
				}
			}
		}
		if (sorgStatus3 != null) {
			for (int i = 0; i < ds.getCount(); i++) {
				if (ds.getRecord(i).get("sorgStatus").equals(sorgStatus2)) {
					num++;
				}
			}
		}
		return ("" + num);
	}
	
	/**
	 * 根据sorgId来查询法人政治面貌
	 */
	public String queryQolitics(String sorgId) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID@=", sorgId);
		pset.setParameter("PEOPLE_TYPE@=", "L");
		SomDuty somMember = (SomDuty) somDutyDomain.query(pset)
				.getRecord(0).toBean(SomDuty.class);
		String peopleId = somMember.getPeopleId();
		ParameterSet pset2 = new ParameterSet();
		pset2.setParameter("PEOPLE_ID@=", peopleId);
		SomPeople somPeople = (SomPeople) somPeopleDomain.query(pset2)
				.getRecord(0).toBean(SomPeople.class);
		String politics = somPeople.getPolitics();
		return ("" + politics);
	}
	/**
	 * 社会团体的会费标准备案的查询
	 * @param pset
	 * @return
	 */
	public DataSet queryFee(ParameterSet pset) {
		pset.setParameter("SORG_TYPE@=","S");
		pset.setParameter("MEETING_TYPE@=","F");
		if(pset.containsKey("cnName")){
			String cnName = (String) pset.getParameter("cnName");
			ParameterSet p = new ParameterSet();
			p.setParameter("CN_NAME@=", cnName);
			DataSet ds = queryOrgan(p);
			if(ds.getCount() == 1){
				pset.put("SORG_ID@=", (String)ds.getRecord(0).get("sorgId"));
			}else{
				if(cnName.trim().equals("")){
					pset.put("SORG_ID@=", "");
				}else {
					pset.put("SORG_ID@=", "null");
				}
			}
			pset.remove("cnName");
		}
		return somMeetingDomain.query(pset);
	}
	/**
	 * 社会团体办事机构的查询
	 * @param pset
	 * @return
	 */
	public DataSet queryOffice(ParameterSet pset) {
		pset.setParameter("SORG_TYPE@=","S");
		if(pset.containsKey("cnName")){
			String cnName = (String) pset.getParameter("cnName");
			ParameterSet p = new ParameterSet();
			p.setParameter("CN_NAME@=", cnName);
			DataSet ds = queryOrgan(p);
			if(ds.getCount() == 1){
				pset.put("SORG_ID@=", (String)ds.getRecord(0).get("sorgId"));
			}else{
				if(cnName.trim().equals("")){
					pset.put("SORG_ID@=", "");
				}else {
					pset.put("SORG_ID@=", "null");
				}
			}
			pset.remove("cnName");
		}
		return somOfficeDomain.query(pset);
	}
	/**
	 * 社会团体的章程备案的查询
	 * @param pset
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryRule(ParameterSet pset) {
		pset.setParameter("SORG_TYPE@=","S");
		pset.setParameter("MEETING_TYPE@=","Z");
		if(pset.containsKey("cnName")){
			String cnName = (String) pset.getParameter("cnName");
			ParameterSet p = new ParameterSet();
			p.setParameter("CN_NAME@=", cnName);
			DataSet ds = queryOrgan(p);
			if(ds.getCount() == 1){
				pset.put("SORG_ID@=", (String)ds.getRecord(0).get("sorgId"));
			}else{
				if(cnName.trim().equals("")){
					pset.put("SORG_ID@=", "");
				}else {
					pset.put("SORG_ID@=", "null");
				}
			}
			pset.remove("cnName");
		}
		return somMeetingDomain.query(pset);
	}
	
	
	/**
	 * 获取所有证书信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryCert(ParameterSet pset) {
		DataSet SETS = somCertDomain.query(pset);
		return SETS;
	}

	/**
	 * 更新证书信息
	 * 
	 * @param somCert
	 * @return
	 */
	public void updateCert(SomCert somCert) {
		somCertDomain.update(somCert);

	}

	/**
	 * 添加一条新的证书信息
	 * 
	 * @param somCert
	 * @return
	 */
	public String insertCert(SomCert somCert) {
		return somCertDomain.insert(somCert);
	}

	/**
	 * 收回证书 2011年5月17日19:59:34
	 */
	public void receive(SomCert somCert) {
		somCertDomain.receive(somCert);

	}

	/**
	 * 综合查询中根据证书查询社会组织ID
	 */
	public String queryCertForQuery(ParameterSet pset) {
		return somCertDomain.queryForQuery(pset);
	}

	/**
	 *  人员综合查询中查询member表 2011年6月10日15:21:48
	 */
	public String queryMemberForP(ParameterSet pset) {
		pset.setParameter("if_Valid@=", "2");
		DataSet ds = somDutyDomain.query(pset);
		RecordSet rs = ds.getRecordSet();
		String idString = "";
		for (int i = 0; i < rs.size(); i++) {
			idString += rs.get(i).get("peopleId") + ",";
		}
		return idString;
	}
	// ---------------------------------------------zhaojin-----------------------------------------------
	/**
	 * set社会组织信息
	 */
	private void setOrgan(SomOrgan organBean, String ifBranch) {
		// set基本信息
		organBean.setSorgId(IdHelp.getUUID30());
		organBean.setSorgStatus("21");
		organBean.setIfBranch(ifBranch);
		organBean.setMorgName(BspUtil.getCorpOrgan().getOrganName());
		organBean.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
	}
	/**
	 * 社团分支/代表信息登记保存并提交
	 */
	public void saveAndCreateBranchBuild(SomOrgan organBean, SomFlow somFlow) {
		// 保存分支基本信息
		setOrgan(organBean, "1");
		organBean.setSorgType("S");
		somOrganDomain.insert(organBean);
		// 组装社会组织业务申请信息表
		SomApply somApply = getSomApplyInfoAccept(somFlow, organBean);
		CommandContext.setContextParameter("procDefUniqueId",
				"4028b881314bf48801314bf83f050001");
		CommandContext.setContextParameter("startActDefUniqueId",
				"4028b8813150d381013150d647e80092");
		Map context = new HashMap();
		String StruId = BspUtil.getDeptStruId();
		context.put("ORGANID", StruId);
		Map map = WfTaskRequestWrapper.getInstance()
				.createAndSend(organBean.getSorgId(),
						organBean.getCnName() + "的登记申请", context);
		String processId = (String) map.get("processId");
		somFlow.setTaskCode(processId);
		somFlow.setSorgId(organBean.getSorgId());
		this.somFlowDomain.insert(somFlow);
		// 插入社会组织业务申请信息表
		somApply.setTaskCode(processId);
		this.somApplyDomain.insert(somApply);
	}

	public SomApply getSomApplyInfoAccept(SomFlow somFlow, SomOrgan organBean) {
		// 组装社会组织业务申请信息表
		SomApply somApply = new SomApply();
		somApply.setTaskCode(somFlow.getTaskCode());
		somApply.setSorgId(organBean.getSorgId());
		somApply.setApplyType(somFlow.getApplyType());
		somApply.setSorgType(organBean.getSorgType());
		somApply.setSorgKind(organBean.getSorgKind());
		somApply.setSorgName(organBean.getCnName());
		somApply.setAcceptOrganId(BspUtil.getCorpOrganId());
		somApply.setAcceptDeptId(BspUtil.getDeptOrganId());
		somApply.setAcceptPeopleId(BspUtil.getEmpOrganId());
		somApply.setAcceptTime(organBean.getCreateTime());
		somApply.setCurActivity(Activity.ACT_EXAM_CN);
		return somApply;
	}

	public void sendBranchBuild(SomOrgan organBean, SomFlow somFlow,
			String actDefUniqueId, String actDefName, String processId) {
		ISomApplyDomain applyService = ScaComponentFactory.getService(
				ISomApplyDomain.class, "SomApplyDomain/SomApplyDomain");
		SomApply somApply = applyService.getSomApply(processId);
		
		dealSomApplyInfo(somFlow, somApply, actDefUniqueId, actDefName);
		Map context = new HashMap();
		String StruId = BspUtil.getDeptStruId();
		context.put("ORGANID", StruId);
		context.put("opinionId", somFlow.getOpinionId());
		// 调用工作流发送接口
		Map map = WfTaskRequestWrapper.getInstance().send(context);
		String isEnd = (String) map.get("isEnd");
		// 插入一条流程意见
		this.somFlowDomain.insert(somFlow);
		// 判断下流程是否结束，结束了给组织机构状态赋值
		if (isEnd != null) {
			somApply.setIfFinish("1");
			somApply.setCurActivity("结束");
			// 审批意见同意，赋值已筹备
			if (isEnd.equals("true") && somFlow.getOpinionId().equals("0")) {
				organBean.setSorgStatus("22");
			}
			// 审批意见不同意，赋值筹备申请未通过
			if (isEnd.equals("true") && somFlow.getOpinionId().equals("1")) {
				organBean.setSorgStatus("23");
			}
		} else {
			List actList = (List) map.get("actList");
			Map actMap = (Map) actList.get(0);
			String nextActDefName = (String) actMap.get("actDefName");
			somApply.setCurActivity(nextActDefName);
		}
		// 插入社会组织业务申请信息表
		this.somApplyDomain.update(somApply);
		somOrganDomain.update(organBean);
	}

	public SomApply dealSomApplyInfo(SomFlow somFlow, SomApply somApply,
			String actDefUniqueId, String actDefName) {
		Boolean ifAudit = WfQueryDCwork.isApproveAct(actDefUniqueId);
		if (ifAudit) {
			somApply.setAuditOpinion(somFlow.getOpinionId());
			somApply.setAuditOrganId(BspUtil.getCorpOrganId());
			somApply.setAuditDeptId(BspUtil.getDeptOrganId());
			somApply.setAuditPeopleId(BspUtil.getEmpOrganId());
			somApply.setAuditTime(DateUtil.getTime());
		}
		return somApply;
	}

	public SomApply getSomApplyInfoBuild(SomFlow somFlow, SomOrgan organBean) {
		// 组装社会组织业务申请信息表
		SomApply somApply = new SomApply();
		somApply.setTaskCode(somFlow.getTaskCode());
		somApply.setSorgId(organBean.getSorgId());
		somApply.setApplyType(somFlow.getApplyType());
		somApply.setSorgType(organBean.getSorgType());
		somApply.setSorgKind(organBean.getSorgKind());
		somApply.setSorgName(organBean.getCnName());
		somApply.setAcceptOrganId(BspUtil.getCorpOrganId());
		somApply.setAcceptDeptId(BspUtil.getDeptOrganId());
		somApply.setAcceptPeopleId(BspUtil.getEmpOrganId());
		somApply.setAcceptTime(organBean.getCreateTime());
		somApply.setCurActivity(Activity.ACT_EXAM_CN);
		return somApply;
	}
}
