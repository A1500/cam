package com.inspur.cams.drel.sam.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.drel.sam.data.SamPeopleAccident;
import com.inspur.cams.drel.sam.data.SamPeopleDisability;
import com.inspur.cams.drel.sam.data.SamPeopleDisease;
import com.inspur.cams.drel.sam.data.SamPeopleEdu;
import com.inspur.cams.drel.sam.domain.IBaseinfoFamilyDomain;
import com.inspur.cams.drel.sam.domain.IBaseinfoPeopleDomain;

/**
 * @title:SamBasePeopleCmd
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
 */
public class SamBasePeopleCmd extends BaseQueryCommand {

	public DataSet execute() {
		IBaseinfoFamilyDomain ygjzjtxxDomain = ScaComponentFactory.getService(
				IBaseinfoFamilyDomain.class, "SamBaseinfoFamilyDomain/SamBaseinfoFamilyDomain");
		ParameterSet pset = getParameterSet();
		return ygjzjtxxDomain.queryYgjzJtxxCyxx(pset);
	}

	public DataSet itemQuery() {
		ParameterSet pset = getParameterSet();
		IBaseinfoFamilyDomain ygjzjtxxDomain = ScaComponentFactory.getService(
				IBaseinfoFamilyDomain.class, "SamBaseinfoFamilyDomain/SamBaseinfoFamilyDomain");
		DataSet ds = ygjzjtxxDomain.itemQuery(pset);
		return ds;
	}

	/**
	 * 家庭成员信息登记
	 */
	public void save() {
		IBaseinfoFamilyDomain ygjzjtxxDomain = ScaComponentFactory.getService(
				IBaseinfoFamilyDomain.class, "SamBaseinfoFamilyDomain/SamBaseinfoFamilyDomain");
		Record[] BaseinfoPeopleRecords = (Record[]) getParameter("BaseinfoPeopleRecords");
		List<BaseinfoPeople> list = new ArrayList<BaseinfoPeople>();
		String familyId = "";
		for (int i = 0; i < BaseinfoPeopleRecords.length; i++) {
			BaseinfoPeople ygjzjtxxcyxx = (BaseinfoPeople) BaseinfoPeopleRecords[i]
					.toBean(BaseinfoPeople.class);
			list.add(ygjzjtxxcyxx);
			familyId = ygjzjtxxcyxx.getFamilyId();
		}
		ygjzjtxxDomain.saveYgjzJtxxCyxx(list);

		ygjzjtxxDomain.updatePeopleNum(familyId);

	}

	/**
	 * 家庭成员信息注销
	 */
	public void delete() {
		//成员表删除
		EntityDao<BaseinfoPeople> dao = (EntityDao<BaseinfoPeople>) DaoFactory.getDao("com.inspur.cams.comm.baseinfo.dao.jdbc.BaseinfoPeopleDao");
		String delId = (String) getParameter("delId");
		String familyId = (String) getParameter("familyId");
		dao.delete(delId);
        //人员残疾表删除
		EntityDao<SamPeopleDisability> Disabilitydao = (EntityDao<SamPeopleDisability>) DaoFactory.getDao("com.inspur.cams.drel.sam.dao.jdbc.SamPeopleDisabilityDao");
		Disabilitydao.delete(delId);
		//人员教育表删除
		EntityDao<SamPeopleEdu> Edudao = (EntityDao<SamPeopleEdu>) DaoFactory.getDao("com.inspur.cams.drel.sam.dao.jdbc.SamPeopleEduDao");
		Edudao.delete(delId);
		//人员患病表删除
		EntityDao<SamPeopleDisease> Diseasedao = (EntityDao<SamPeopleDisease>) DaoFactory.getDao("com.inspur.cams.drel.sam.dao.jdbc.SamPeopleDiseaseDao");
		Diseasedao.delete(delId);
		//人员事故表删除
		EntityDao<SamPeopleAccident> Accidentdao = (EntityDao<SamPeopleAccident>) DaoFactory.getDao("com.inspur.cams.drel.sam.dao.jdbc.SamPeopleAccidentDao");
		Accidentdao.delete(delId);
        //修改成员数
		IBaseinfoFamilyDomain ygjzjtxxDomain = ScaComponentFactory.getService(
				IBaseinfoFamilyDomain.class, "SamBaseinfoFamilyDomain/SamBaseinfoFamilyDomain");
		ygjzjtxxDomain.updatePeopleNum(familyId);

	}

	/**
	 * 添加家庭成员信息 弹出页面保存
	 */
	@Trans
	public void saveJtcy() {
		IBaseinfoPeopleDomain service = ScaComponentFactory.getService(
				IBaseinfoPeopleDomain.class,
				"SamBaseinfoPeopleDomain/SamBaseinfoPeopleDomain");

		String opType = (String) getParameter("opType");
		if (opType == null) {
			opType = "accept";
		}
		BaseinfoPeople ygjzjtxxcyxx = getYgjzJtxxCyxx(opType);
		List ygjzjtxxCyxxList = new ArrayList();
		ygjzjtxxCyxxList.add(ygjzjtxxcyxx);
		service.saveYgjzJtxxCyxx(ygjzjtxxCyxxList);

//		String nowTime = DateUtil.getNewTime();
//		String familyId = ygjzjtxxcyxx.getFamilyId();// 家庭ID

//		String areaCode = ygjzjtxxcyxx.getRegOrgArea();
//		String employeeName = ygjzjtxxcyxx.getCheckPeople();

		// 存取家庭成员照片
//		dealPhotoC(ygjzjtxxcyxx, nowTime, areaCode, employeeName);// 处理照片


        //人员教育保存
		List YgjzCyxxJyxxList = getYgjzCyxxJyxxList();
		service.saveYgjzCyxxJyxxList(YgjzCyxxJyxxList);
		//人员残疾保存
		List YgjzCyxxCjxxList = getYgjzCyxxCjxxList();
		service.saveYgjzCyxxCjxx(YgjzCyxxCjxxList);
		//人员患病保存
		List YgjzCyxxHbxxList = getYgjzCyxxHbxxList();
		service.saveYgjzCyxxHbxx(YgjzCyxxHbxxList);
		//人员事故保存
		List YgjzCyxxSgxxList = getYgjzCyxxSgxxList();
		service.saveYgjzCyxxSgxx(YgjzCyxxSgxxList);

		IBaseinfoFamilyDomain ygjzjtxxDomain = ScaComponentFactory.getService(
				IBaseinfoFamilyDomain.class, "SamBaseinfoFamilyDomain/SamBaseinfoFamilyDomain");
		ygjzjtxxDomain.updatePeopleNum(ygjzjtxxcyxx.getFamilyId());

	}

	/**
	 * 家庭成员信息获取
	 *
	 * @return
	 */
	private BaseinfoPeople getYgjzJtxxCyxx(String opType) {
		Record BaseinfoPeopleRecord = (Record) getParameter("BaseinfoPeopleRecord");
		BaseinfoPeople bean = (BaseinfoPeople) BaseinfoPeopleRecord
				.toBean(BaseinfoPeople.class);

		if ("accept".equals(opType)) {
			bean.setRegId(BspUtil.getEmpOrganId());
			bean.setRegPeople(BspUtil.getEmpOrgan().getOrganName());
			bean.setRegOrg(BspUtil.getCorpOrganId());
			bean.setRegOrgName(BspUtil.getCorpOrgan().getOrganName());
			bean.setRegOrgArea(BspUtil.getCorpOrgan().getOrganCode());
			bean.setRegTime(DateUtil.getTime());
		} else if ("correct".equals(opType)) {
			bean.setModId(BspUtil.getEmpOrganId());
			bean.setModPeople(BspUtil.getEmpOrgan().getOrganName());
			bean.setModOrg(BspUtil.getCorpOrganId());
			bean.setModOrgName(BspUtil.getCorpOrgan().getOrganName());
			bean.setModOrgArea(BspUtil.getCorpOrgan().getOrganCode());
			bean.setModTime(DateUtil.getTime());
		} else if ("exam".equals(opType)) {
			bean.setCheckId(BspUtil.getEmpOrganId());
			bean.setCheckPeople(BspUtil.getEmpOrgan().getOrganName());
			bean.setCheckOrg(BspUtil.getCorpOrganId());
			bean.setCheckOrgName(BspUtil.getCorpOrgan().getOrganName());
			bean.setCheckOrgArea(BspUtil.getCorpOrgan().getOrganCode());
			bean.setCheckTime(DateUtil.getTime());
		}

		return bean;
	}
	/**
	 * 教育信息从表添加
	 *
	 * @return
	 */
	private List<SamPeopleEdu> getYgjzCyxxJyxxList() {
		Record[] ygjzcyxxjyxxRecords = (Record[]) getParameter("YgjzCyxxJyxxRecords");
		if (ygjzcyxxjyxxRecords == null || ygjzcyxxjyxxRecords.length == 0) {
			return null;
		}
		List<SamPeopleEdu> list = new ArrayList<SamPeopleEdu>();
		for (int i = 0; i < ygjzcyxxjyxxRecords.length; i++) {
			SamPeopleEdu ygjzcyxxjyxx = (SamPeopleEdu) ygjzcyxxjyxxRecords[i]
					.toBean(SamPeopleEdu.class);
			list.add(ygjzcyxxjyxx);
		}

		return list;
	}
	/**
	 * 患病信息从表添加
	 *
	 * @return
	 */
	private List<SamPeopleDisease> getYgjzCyxxHbxxList() {
		Record[] ygjzcyxxhbxxRecords = (Record[]) getParameter("YgjzCyxxHbxxRecords");
		if (ygjzcyxxhbxxRecords == null || ygjzcyxxhbxxRecords.length == 0) {
			return null;
		}
		List<SamPeopleDisease> list = new ArrayList<SamPeopleDisease>();
		for (int i = 0; i < ygjzcyxxhbxxRecords.length; i++) {
			SamPeopleDisease ygjzcyxxhbxx = (SamPeopleDisease) ygjzcyxxhbxxRecords[i]
					.toBean(SamPeopleDisease.class);
			list.add(ygjzcyxxhbxx);
		}

		return list;
	}

	/**
	 * 事故信息从表添加
	 *
	 * @return
	 */
	private List<SamPeopleAccident> getYgjzCyxxSgxxList() {
		Record[] ygjzcyxxsgxxRecords = (Record[]) getParameter("YgjzCyxxSgxxRecords");
		if (ygjzcyxxsgxxRecords == null || ygjzcyxxsgxxRecords.length == 0) {
			return null;
		}
		List<SamPeopleAccident> list = new ArrayList<SamPeopleAccident>();
		for (int i = 0; i < ygjzcyxxsgxxRecords.length; i++) {
			SamPeopleAccident ygjzcyxxsgxx = (SamPeopleAccident) ygjzcyxxsgxxRecords[i]
					.toBean(SamPeopleAccident.class);
			list.add(ygjzcyxxsgxx);
		}

		return list;
	}
	/**
	 * 残疾信息从表添加
	 *
	 * @return
	 */
	private List<SamPeopleDisability> getYgjzCyxxCjxxList() {
		Record[] ygjzcyxxcjxxRecords = (Record[]) getParameter("YgjzCyxxCjxxRecords");
		if (ygjzcyxxcjxxRecords == null || ygjzcyxxcjxxRecords.length == 0) {
			return null;
		}
		List<SamPeopleDisability> list = new ArrayList<SamPeopleDisability>();
		for (int i = 0; i < ygjzcyxxcjxxRecords.length; i++) {
			SamPeopleDisability ygjzcyxxcjxx = (SamPeopleDisability) ygjzcyxxcjxxRecords[i]
					.toBean(SamPeopleDisability.class);
			list.add(ygjzcyxxcjxx);
		}

		return list;
	}


}