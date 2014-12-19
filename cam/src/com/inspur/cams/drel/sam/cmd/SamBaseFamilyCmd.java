package com.inspur.cams.drel.sam.cmd;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.bsp.id.util.MaxValueUtil;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.baseinfo.dao.jdbc.BaseinfoPeopleDao;
import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.PhotoUtil;
import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.drel.sam.dao.jdbc.SamFamilyAssistanceDao;
import com.inspur.cams.drel.sam.dao.jdbc.SamFamilyCalamityDao;
import com.inspur.cams.drel.sam.data.SamFamilyAssistance;
import com.inspur.cams.drel.sam.data.SamFamilyCalamity;
import com.inspur.cams.drel.sam.data.SamPeopleAccident;
import com.inspur.cams.drel.sam.data.SamPeopleDisability;
import com.inspur.cams.drel.sam.data.SamPeopleDisease;
import com.inspur.cams.drel.sam.data.SamPeopleEdu;
import com.inspur.cams.drel.sam.domain.IBaseinfoFamilyDomain;
import com.inspur.cams.drel.sam.domain.IBaseinfoPeopleDomain;

/**
 * @title:YgjzJtxxSaveCommand
 * @description:
 * @since:2011-04-18
 * @version:1.0
 */
public class SamBaseFamilyCmd extends BaseAjaxCommand {
	/**
	 *
	 * 登记家庭信息和户主信息
	 */
	public void save() {
		// 获取服务调用查询方法
		IBaseinfoFamilyDomain service = ScaComponentFactory.getService( IBaseinfoFamilyDomain.class, "SamBaseinfoFamilyDomain/SamBaseinfoFamilyDomain");
		IBaseinfoPeopleDomain cyxxService = ScaComponentFactory.getService( IBaseinfoPeopleDomain.class, "SamBaseinfoPeopleDomain/SamBaseinfoPeopleDomain");
		String opType = (String) getParameter("opType");
		if(opType == null){
			opType = "accept";
		}
		BaseinfoFamily baseinfoFamily = getYgjzJtxx("accept");
		String nowTime = DateUtil.getTime();
		String FamilyId = baseinfoFamily.getFamilyId();//家庭ID

		String areaCode=baseinfoFamily.getRegOrgArea();
		String employeeName=baseinfoFamily.getRegPeople();
		//照片处理
		if(!"".equals(StrUtil.n2b(baseinfoFamily.getPhotoTemp())) ){
			String photoId = PhotoUtil.savePhoto(baseinfoFamily.getPhotoTemp());
			baseinfoFamily.setPhotoId(photoId);
		}
		//救助类型
		Record[] SamFamilyAssistanceList =(Record[])getParameter("assistanceTypeList");
		if(SamFamilyAssistanceList!=null){
			List<SamFamilyAssistance> SamFamilyAssistanceList2 =new ArrayList<SamFamilyAssistance>();
			for(int i=0;i<SamFamilyAssistanceList.length;i++){

				SamFamilyAssistance bean=(SamFamilyAssistance)SamFamilyAssistanceList[i].toBean(SamFamilyAssistance.class);
				SamFamilyAssistanceList2.add(bean);
			}
			//判断，如果opType＝update,说明是从变更页面提交保存按钮过来的，执行两个参数的方法；反之是从登记页面保存过来的，执行一个参数的方法。
				if("update".equals(opType)){
					service.saveSamFamilyAssistance(SamFamilyAssistanceList2,FamilyId);
				}else{
					service.saveSamFamilyAssistance(SamFamilyAssistanceList2);
				}
		}else{
		}

		// 家庭信息-自然灾害保存
		List<SamFamilyCalamity> YgjzJtxxZrzhList = getYgjzJtxxZrzhList();
		service.saveYgjzJtxxZrzh(YgjzJtxxZrzhList);
		//家庭信息
		List<BaseinfoFamily> ygjzjtxxList = new ArrayList<BaseinfoFamily>();
		ygjzjtxxList.add(baseinfoFamily);
		service.saveYgjzJtxx(ygjzjtxxList);

		if("accept".equals(opType)){

			//成员教育保存
			List YgjzCyxxJyxxList = getYgjzCyxxJyxxList();
			cyxxService.saveYgjzCyxxJyxx(YgjzCyxxJyxxList);
			//成员残疾保存
			List YgjzCyxxCjxxList = getYgjzCyxxCjxxList();
			cyxxService.saveYgjzCyxxCjxx(YgjzCyxxCjxxList);
			//成员患病保存
			List YgjzCyxxHbxxList = getYgjzCyxxHbxxList();
			cyxxService.saveYgjzCyxxHbxx(YgjzCyxxHbxxList);
			//成员事故保存
			List YgjzCyxxSgxxList = getYgjzCyxxSgxxList();
			cyxxService.saveYgjzCyxxSgxx(YgjzCyxxSgxxList);
			//户主信息保存
			BaseinfoPeople baseinfoPeople = getYgjzJtxxCyxx(opType);//成员信息
			if(!"".equals(StrUtil.n2b(baseinfoPeople.getPhotoTemp())) ){
				String photoId = PhotoUtil.savePhoto(baseinfoPeople.getPhotoTemp());
				baseinfoPeople.setPhotoId(photoId);
			}
			List baseinfoPeopleList = new ArrayList();
			baseinfoPeopleList.add(baseinfoPeople);
			cyxxService.saveYgjzJtxxCyxx(baseinfoPeopleList);

			//更新家庭信息
			service.updatePeopleNum(FamilyId);
		}
        //更新
		if("update".equals(opType)){
			BaseinfoFamily baseinfoFamilyUpdate = getYgjzJtxx("update");
			service.updateFamily(baseinfoFamily);
		}
	}
	/**
	 * 审核提交
	 */
	public void exam() {
		// 获取服务调用查询方法
		IBaseinfoFamilyDomain service = ScaComponentFactory.getService(IBaseinfoFamilyDomain.class, "SamBaseinfoFamilyDomain/SamBaseinfoFamilyDomain");
		BaseinfoFamily ygjzjtxx = getYgjzJtxx("exam");
		List<BaseinfoFamily> ygjzjtxxList = new ArrayList<BaseinfoFamily>();
		ygjzjtxxList.add(ygjzjtxx);

		service.saveYgjzJtxx(ygjzjtxxList);
	}

	/**
	 * 更正提交
	 */
	public void correct() {
		// 获取服务调用查询方法
		IBaseinfoFamilyDomain service = ScaComponentFactory.getService(IBaseinfoFamilyDomain.class, "SamBaseinfoFamilyDomain/SamBaseinfoFamilyDomain");

		BaseinfoFamily ygjzjtxx = getYgjzJtxx("correct");
		String FamilyId = ygjzjtxx.getFamilyId();
		String nowTime = DateUtil.getTime();
		String areaCode=ygjzjtxx.getRegOrgArea();
		String employeeName=ygjzjtxx.getRegPeople();

		List<BaseinfoFamily> ygjzjtxxList = new ArrayList<BaseinfoFamily>();
		ygjzjtxxList.add(ygjzjtxx);

		service.saveYgjzJtxx(ygjzjtxxList);
	}
	/**
	 *
	 * 移交到审核
	 */
	public void toExam() {
		// 获取服务调用查询方法
		IBaseinfoFamilyDomain service = ScaComponentFactory.getService(IBaseinfoFamilyDomain.class, "SamBaseinfoFamilyDomain/SamBaseinfoFamilyDomain");
		//当前登陆人单位区划
		String  organCode=BspUtil.getCorpOrgan().getOrganCode();
		String[] jtids = (String[]) getParameter("jtids");
		String jtidStr = "";
		for (int i = 0; i < jtids.length; i++) {
			if (jtidStr.length() > 0)
				jtidStr += ",";
			jtidStr += jtids[i];
		}
		 String createOrgan="";
		 if(organCode.substring(2,12).equals("0000000000")){
				createOrgan=organCode;
			}else if(organCode.substring(4,12).equals("00000000")){
				createOrgan=organCode;
			}else if(organCode.substring(6,12).equals("000000")||organCode.substring(6,12)=="000000"){
				createOrgan=organCode;
			}else if(organCode.substring(9,12).equals("000")){
				createOrgan=organCode.substring(0,6)+"000000";
			}else  {
				createOrgan=organCode.substring(0,6)+"000000";
		 }
		service.updateCurrentActivity("EXAM", jtidStr,createOrgan);
	}
	/**
	 *
	 * 更新救助指数
	 */
	public void updateJzzs() {
		// 获取服务调用查询方法
		IBaseinfoFamilyDomain service = ScaComponentFactory.getService(IBaseinfoFamilyDomain.class, "BaseinfoFamilyDomain/BaseinfoFamilyDomain");
		//当前登陆人单位区划

		String  organCode=BspUtil.getCorpOrgan().getOrganCode();
		String[] jtids = (String[]) getParameter("jtids");
		for (int i = 0; i < jtids.length; i++) {
				service.updateJtdz( jtids[i]);//JTDZ: 1
		}


	}
	/**
	 * @author 信息注销
	 */
	public void delete() {
		IBaseinfoFamilyDomain service = ScaComponentFactory.getService(IBaseinfoFamilyDomain.class, "SamBaseinfoFamilyDomain/SamBaseinfoFamilyDomain");
		String[] delId = (String[]) getParameter("delIds");
		List<String> list = new ArrayList<String>();
		for (int i = 0; i < delId.length; i++) {
			list.add(delId[i]);
		}
		// 家庭成员
		BaseinfoPeopleDao BaseinfoPeopleDao = null;
		try {
			BaseinfoPeopleDao = new BaseinfoPeopleDao();
		} catch (Exception e) {
			e.printStackTrace();
		}
		BaseinfoPeopleDao.bathchDeleteByFamilyId(delId);
		// 受助类型
		SamFamilyAssistanceDao ygjzjtxxszlxDao = null;
		try {
			ygjzjtxxszlxDao = new SamFamilyAssistanceDao();
		} catch (Exception e) {
			e.printStackTrace();
		}
		ygjzjtxxszlxDao.bathchDeleteByFamilyId(delId);
		// 自然灾害
		SamFamilyCalamityDao SamFamilyCalamityDao = null;
		try {
			SamFamilyCalamityDao = new SamFamilyCalamityDao();
		} catch (Exception e) {
			e.printStackTrace();
		}
		SamFamilyCalamityDao.batchDeleteByYgjzJtxx(delId);

		service.delete(list);
	}

	/**
	 * 家庭信息获取
	 *
	 * @return
	 */
	private BaseinfoFamily getYgjzJtxx(String opType) {
		Record BaseinfoFamilyRecord = (Record) getParameter("BaseinfoFamilyRecord");
		BaseinfoFamily bean = (BaseinfoFamily) BaseinfoFamilyRecord.toBean(BaseinfoFamily.class);

		if ("accept".equals(opType)) {
			bean.setRegId(BspUtil.getEmpOrganId());
			bean.setRegPeople(BspUtil.getEmpOrgan().getOrganName());
			bean.setRegOrg(BspUtil.getCorpOrganId());
			bean.setRegOrgName(BspUtil.getCorpOrgan().getOrganName());
			bean.setRegOrgArea(BspUtil.getCorpOrgan().getOrganCode());
			bean.setRegTime(DateUtil.getTime());
		} else if ("correct".equals(opType)) {
			bean.setCurActivity("ACCEPT");
			bean.setCheckFlag("1");
			bean.setModId(BspUtil.getEmpOrganId());
			bean.setModPeople(BspUtil.getEmpOrgan().getOrganName());
			bean.setModOrg(BspUtil.getCorpOrganId());
			bean.setModOrgName(BspUtil.getCorpOrgan().getOrganName());
			bean.setModOrgArea(BspUtil.getCorpOrgan().getOrganCode());
			bean.setModTime(DateUtil.getTime());
		} else if ("exam".equals(opType)) {
			String shbz=bean.getCheckFlag();
			if(shbz.equals("0")){
				bean.setCurActivity("CORRECT");//转更正
			 }else
			if(shbz.equals("3")){
			bean.setCurActivity("FINISHOK");//审核完结通过
			}else  if(shbz.equals("2")){
			bean.setCurActivity("FINISHNO");//审核完结未通过
			}else if(shbz.equals("1")) {
			bean.setCurActivity("EXAM");//不做操作
			}
			bean.setCheckId(BspUtil.getEmpOrganId());
			bean.setCheckPeople(BspUtil.getEmpOrgan().getOrganName());
			bean.setCheckOrg(BspUtil.getCorpOrganId());
			bean.setCheckOrgName(BspUtil.getCorpOrgan().getOrganName());
			bean.setCheckOrgArea(BspUtil.getCorpOrgan().getOrganCode());
			bean.setCheckTime(DateUtil.getTime());
		}else if("update".equals(opType)){
			bean.setRegId(BspUtil.getEmpOrganId());
			bean.setRegPeople(BspUtil.getEmpOrgan().getOrganName());
			bean.setRegOrg(BspUtil.getCorpOrganId());
			bean.setRegOrgName(BspUtil.getCorpOrgan().getOrganName());
			bean.setRegOrgArea(BspUtil.getCorpOrgan().getOrganCode());
			bean.setRegTime(DateUtil.getTime());
		}
		return bean;
	}

	/**
	 * 家庭成员信息获取
	 *
	 * @return
	 */
	private List<BaseinfoPeople> getYgjzJtxxCyxxList() {
		Record[] BaseinfoPeopleRecords = (Record[]) getParameter("BaseinfoPeopleRecords");
		if (BaseinfoPeopleRecords == null || BaseinfoPeopleRecords.length == 0) {
			return null;
		}
		List<BaseinfoPeople> list = new ArrayList<BaseinfoPeople>();
		for (int i = 0; i < BaseinfoPeopleRecords.length; i++) {
			BaseinfoPeople ygjzjtxxcyxx = (BaseinfoPeople) BaseinfoPeopleRecords[i].toBean(BaseinfoPeople.class);

			list.add(ygjzjtxxcyxx);
		}
		return list;
	}


	/**
	 * 获取生成身份证号码----jiang
	 *
	 */
	public void getMaxCode(){
		String organCode=BspUtil.getCorpOrgan().getOrganCode();//当前登录行政区划
		String idcardCode = MaxValueUtil.nextStringValue("IDCard_CODE");
		String idCardExtend="B"+organCode+idcardCode;
		setReturn("idCardExtend", idCardExtend);
	}
	/**
	 * 获取生成身份证号码
	 *
	 */
	public void setPhotoInfo(){
		String organCode=BspUtil.getCorpOrgan().getOrganCode();//当前登录行政区划
		String idcardCode = MaxValueUtil.nextStringValue("IDCard_CODE");
		String idCardExtend="B"+organCode+idcardCode;
		setReturn("idCardExtend", idCardExtend);
	}

	/**
	 * 家庭成员信息获取
	 *
	 * @return
	 */
	private BaseinfoPeople getYgjzJtxxCyxx(String opType) {
		Record BaseinfoPeopleRecord = (Record) getParameter("BaseinfoPeopleRecord");
		BaseinfoPeople bean = (BaseinfoPeople) BaseinfoPeopleRecord.toBean(BaseinfoPeople.class);
		String FamilyId=bean.getFamilyId();
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
	 * 家庭信息--从新增页面获得自然灾害记录
	 *
	 * @return
	 */
	private List<SamFamilyCalamity> getYgjzJtxxZrzhList() {
		Record[] ygjzjtxxzrzhRecords = (Record[]) getParameter("YgjzJtxxZrzhRecords");

		if (ygjzjtxxzrzhRecords == null || ygjzjtxxzrzhRecords.length == 0) {
			return null;
		}
		List<SamFamilyCalamity> list = new ArrayList<SamFamilyCalamity>();

		for (int i = 0; i < ygjzjtxxzrzhRecords.length; i++) {
			SamFamilyCalamity ygjzjtxxzrzh = (SamFamilyCalamity) ygjzjtxxzrzhRecords[i]
					.toBean(SamFamilyCalamity.class);
			list.add(ygjzjtxxzrzh);
		}

		return list;
	}

	/**
	 * 从新增页面获得家庭成员残疾信息
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
	 * 从新增页面获得家庭成员教育信息
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
	 * 从新增页面获得家庭成员患病信息
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
	 * 从新增页面获得家庭成员事故信息
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
			SamPeopleAccident ygjzcyxxhbxx = (SamPeopleAccident) ygjzcyxxsgxxRecords[i]
					.toBean(SamPeopleAccident.class);
			list.add(ygjzcyxxhbxx);
		}
		return list;
	}

}