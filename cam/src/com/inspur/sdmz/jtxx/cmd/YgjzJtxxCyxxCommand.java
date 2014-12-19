package com.inspur.sdmz.jtxx.cmd;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.extuser.util.ExtBspInfo;
import com.inspur.sdmz.comm.util.BspUtil;
import com.inspur.sdmz.comm.util.DateUtil;
import com.inspur.sdmz.comm.util.PhotoUtil;
import com.inspur.sdmz.jtxx.data.SamPeopleDisability;
import com.inspur.sdmz.jtxx.data.SamPeopleDisease;
import com.inspur.sdmz.jtxx.data.SamPeopleEdu;
import com.inspur.sdmz.jtxx.data.SamPeopleAccident;
import com.inspur.sdmz.jtxx.data.BaseinfoPeople;
import com.inspur.sdmz.jtxx.domain.IYgjzJtxxCyxxDomain;
import com.inspur.sdmz.jtxx.domain.IYgjzJtxxDomain;

/**
 * @title:YgjzJtxxCyxxCommand
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
 */
public class YgjzJtxxCyxxCommand extends BaseQueryCommand {

	public DataSet execute() {
		IYgjzJtxxDomain ygjzjtxxDomain = ScaComponentFactory.getService(
				IYgjzJtxxDomain.class, "YgjzJtxxDomain/YgjzJtxxDomain");
		ParameterSet pset = getParameterSet();
		return ygjzjtxxDomain.queryYgjzJtxxCyxx(pset);
	}

	public DataSet itemQuery() {
		ParameterSet pset = getParameterSet();
		HttpServletRequest request=(HttpServletRequest)getRequest();
		IYgjzJtxxDomain ygjzjtxxDomain = ScaComponentFactory.getService(
				IYgjzJtxxDomain.class, "YgjzJtxxDomain/YgjzJtxxDomain");
		DataSet ds = ygjzjtxxDomain.itemQuery(pset,request);
		return ds;
	}

	/**
	 * 家庭成员信息登记
	 */
	public void save() {
		IYgjzJtxxDomain ygjzjtxxDomain = ScaComponentFactory.getService(
				IYgjzJtxxDomain.class, "YgjzJtxxDomain/YgjzJtxxDomain");
		Record[] ygjzjtxxcyxxRecords = (Record[]) getParameter("ygjzjtxxcyxxRecords");
		List<BaseinfoPeople> list = new ArrayList<BaseinfoPeople>();
		String familyId = "";
		for (int i = 0; i < ygjzjtxxcyxxRecords.length; i++) {
			BaseinfoPeople ygjzjtxxcyxx = (BaseinfoPeople) ygjzjtxxcyxxRecords[i]
					.toBean(BaseinfoPeople.class);
			list.add(ygjzjtxxcyxx);
			familyId = ygjzjtxxcyxx.getFamilyId();
		}
		ygjzjtxxDomain.saveYgjzJtxxCyxx(list);

		ygjzjtxxDomain.updatePeopleNum(familyId);

		// 计算救助指数
		ygjzjtxxDomain.countJtxxJzzs(familyId);
	}

	/**
	 * 家庭成员信息注销
	 */
	public void delete() {
		String delId = (String) getParameter("delId");
		String familyId = (String) getParameter("familyId");
		
		//人员残疾表删除
		EntityDao<SamPeopleDisability> Disabilitydao = (EntityDao<SamPeopleDisability>) DaoFactory.getDao("com.inspur.sdmz.jtxx.dao.jdbc.YgjzCyxxCjxxDao");
		Disabilitydao.delete(delId);
		//人员教育表删除
		EntityDao<SamPeopleEdu> Edudao = (EntityDao<SamPeopleEdu>) DaoFactory.getDao("com.inspur.sdmz.jtxx.dao.jdbc.YgjzCyxxJyxxDao");
		Edudao.delete(delId);
		//人员患病表删除
		EntityDao<SamPeopleDisease> Diseasedao = (EntityDao<SamPeopleDisease>) DaoFactory.getDao("com.inspur.sdmz.jtxx.dao.jdbc.YgjzCyxxHbxxDao");
		Diseasedao.delete(delId);
		//人员事故表删除
		EntityDao<SamPeopleAccident> Accidentdao = (EntityDao<SamPeopleAccident>) DaoFactory.getDao("com.inspur.sdmz.jtxx.dao.jdbc.YgjzCyxxSgxxDao");
		Accidentdao.delete(delId);
		//成员表删除
		EntityDao<BaseinfoPeople> dao = (EntityDao<BaseinfoPeople>) DaoFactory.getDao("com.inspur.sdmz.jtxx.dao.jdbc.YgjzJtxxCyxxDao");
		dao.delete(delId);
        //修改人员数
		IYgjzJtxxDomain ygjzjtxxDomain = ScaComponentFactory.getService(IYgjzJtxxDomain.class, "YgjzJtxxDomain/YgjzJtxxDomain");
		ygjzjtxxDomain.updatePeopleNum(familyId);

		// 计算救助指数
		ygjzjtxxDomain.countJtxxJzzs(familyId);

	}

	/**
	 * 添加家庭成员信息 独立页面
	 */
	public void saveJtcy() {
		IYgjzJtxxCyxxDomain service = ScaComponentFactory.getService(
				IYgjzJtxxCyxxDomain.class,
				"YgjzJtxxCyxxDomain/YgjzJtxxCyxxDomain");

		String opType = (String) getParameter("opType");
		if (opType == null) {
			opType = "accept";
		}
		BaseinfoPeople ygjzjtxxcyxx = getYgjzJtxxCyxx(opType);
		String nowTime = DateUtil.getNewTime();
		String familyId = ygjzjtxxcyxx.getFamilyId();// 家庭ID

		String areaCode = ygjzjtxxcyxx.getRegOrgArea();
		String employeeName = ygjzjtxxcyxx.getRegPeople();

		// 存取家庭成员照片
		dealPhotoC(ygjzjtxxcyxx, nowTime, areaCode, employeeName);// 处理照片
 
		List YgjzCyxxJyxxList = getYgjzCyxxJyxxList();
		service.saveYgjzCyxxJyxxList(ygjzjtxxcyxx, YgjzCyxxJyxxList);

		List YgjzCyxxCjxxList = getYgjzCyxxCjxxList();
		service.saveYgjzCyxxCjxx(YgjzCyxxCjxxList);

		List YgjzCyxxHbxxList = getYgjzCyxxHbxxList();
		service.saveYgjzCyxxHbxx(YgjzCyxxHbxxList);

		List YgjzCyxxSgxxList = getYgjzCyxxSgxxList();
		service.saveYgjzCyxxSgxx(YgjzCyxxSgxxList);
 
		IYgjzJtxxDomain ygjzjtxxDomain = ScaComponentFactory.getService(
				IYgjzJtxxDomain.class, "YgjzJtxxDomain/YgjzJtxxDomain");
		ygjzjtxxDomain.updatePeopleNum(ygjzjtxxcyxx.getFamilyId());
		// 计算救助指数
		ygjzjtxxDomain.countJtxxJzzs(ygjzjtxxcyxx.getFamilyId());
	}

	/**
	 * 家庭成员信息获取
	 *
	 * @return
	 */
	private BaseinfoPeople getYgjzJtxxCyxx(String opType) {
		Record ygjzjtxxcyxxRecord = (Record) getParameter("YgjzJtxxCyxxRecord");
		BaseinfoPeople bean = (BaseinfoPeople) ygjzjtxxcyxxRecord.toBean(BaseinfoPeople.class);
		HttpServletRequest request=(HttpServletRequest)getRequest();
		String organType="";
		try{
			organType= ExtBspInfo.getUserInfo(request).getOrganType();
		}catch(Exception e){
			organType="";
		}
		if(organType==null){
			organType="";
		}
		if ("accept".equals(opType)) {
			if("".equals(organType)){
				bean.setRegId(BspUtil.getEmpOrganId());
				bean.setRegPeople(BspUtil.getEmpOrgan().getOrganName());
				bean.setRegOrg(BspUtil.getCorpOrganId());
				bean.setRegOrgName(BspUtil.getCorpOrgan().getOrganName());
				bean.setRegOrgArea(BspUtil.getCorpOrgan().getOrganCode());
			}else{
				bean.setRegId(ExtBspInfo.getUserInfo(request).getUserId());//登记人ID
				bean.setRegPeople(ExtBspInfo.getUserInfo(request).getUserName());//登记人姓名		
				bean.setRegOrg(ExtBspInfo.getUserInfo(request).getOrganId());//登记单位ID
				bean.setRegOrgName(ExtBspInfo.getUserInfo(request).getOrganName());//登记单位名称
				bean.setRegOrgArea(ExtBspInfo.getUserInfo(request).getAreaCode());
			}
			
			bean.setRegTime(DateUtil.getNewTime());
		} else if ("correct".equals(opType)) {
			if("".equals(organType)){
			bean.setModId(BspUtil.getEmpOrganId());
			bean.setModPeople(BspUtil.getEmpOrgan().getOrganName());
			bean.setModOrg(BspUtil.getCorpOrganId());
			bean.setModOrgName(BspUtil.getCorpOrgan().getOrganName());
			bean.setModOrgArea(BspUtil.getCorpOrgan().getOrganCode());
			}else{
				bean.setModId(ExtBspInfo.getUserInfo(request).getUserId());
				bean.setModPeople(ExtBspInfo.getUserInfo(request).getUserName());
				bean.setModOrg(ExtBspInfo.getUserInfo(request).getOrganId());
				bean.setModOrgName(ExtBspInfo.getUserInfo(request).getOrganName());
				bean.setModOrgArea(ExtBspInfo.getUserInfo(request).getAreaCode());
			}
			bean.setModTime(DateUtil.getNewTime());
		}else if ("change".equals(opType)) {
			if("".equals(organType)){
				bean.setModId(BspUtil.getEmpOrganId());
				bean.setModPeople(BspUtil.getEmpOrgan().getOrganName());
				bean.setModOrg(BspUtil.getCorpOrganId());
				bean.setModOrgName(BspUtil.getCorpOrgan().getOrganName());
				bean.setModOrgArea(BspUtil.getCorpOrgan().getOrganCode());
				}else{
					bean.setModId(ExtBspInfo.getUserInfo(request).getUserId());
					bean.setModPeople(ExtBspInfo.getUserInfo(request).getUserName());
					bean.setModOrg(ExtBspInfo.getUserInfo(request).getOrganId());
					bean.setModOrgName(ExtBspInfo.getUserInfo(request).getOrganName());
					bean.setModOrgArea(ExtBspInfo.getUserInfo(request).getAreaCode());
				}
				bean.setModTime(DateUtil.getNewTime());
		}else if ("exam".equals(opType)) {
			if("".equals(organType)){
			bean.setCheckId(BspUtil.getEmpOrganId());
			bean.setCheckPeople(BspUtil.getEmpOrgan().getOrganName());
			bean.setCheckOrg(BspUtil.getCorpOrganId());
			bean.setCheckOrgName(BspUtil.getCorpOrgan().getOrganName());
			bean.setCheckOrgArea(BspUtil.getCorpOrgan().getOrganCode());
			}else{
				bean.setCheckId(ExtBspInfo.getUserInfo(request).getUserId());
				bean.setCheckPeople(ExtBspInfo.getUserInfo(request).getUserName());
				bean.setCheckOrg(ExtBspInfo.getUserInfo(request).getOrganId());
				bean.setCheckOrgName(ExtBspInfo.getUserInfo(request).getOrganName());
				bean.setCheckOrgArea(ExtBspInfo.getUserInfo(request).getAreaCode());
			}
			bean.setCheckTime(DateUtil.getNewTime());
		}

		return bean;
	}

	/**
	 * 家庭成员List获取
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
	 * 家庭成员 照片处理(申请人证件照片、申请人现场照片)
	 *
	 * @param icmApplyInfo
	 */
	public void dealPhotoC(BaseinfoPeople ygjzjtxxcyxx, String nowTime,
			String areaCode, String employeeName) {
		// 采集证件照片
		String applybase64Code = "";
		String applyId = "";
		applybase64Code = ygjzjtxxcyxx.getPeoplePhotoTemp();
		if (null != applybase64Code && !"".equals(applybase64Code)) {
			// 保存图片到表 COM_PHOTO 中，并返回该图片的主键
			applyId = PhotoUtil.getCrjPhotoId(applybase64Code, "1", "JPG",
					"11", ygjzjtxxcyxx.getFamilyId(), nowTime, areaCode,
					employeeName);
		}

		if (applyId != null && !"".equals(applyId)) {
			ygjzjtxxcyxx.setPhotoId(applyId);
		}

	}
}