package com.inspur.cams.bpt.manage.cmd;

import java.math.BigDecimal;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.dao.jdbc.BptDemobilizedillCheckDao;
import com.inspur.cams.bpt.base.dao.jdbc.BptPeopleValidateDao;
import com.inspur.cams.bpt.base.dao.jdbc.BptPhysicalExaminationDao;
import com.inspur.cams.bpt.base.data.BptDemobilizedillnessCheck;
import com.inspur.cams.bpt.base.data.BptPeopleDemobilized;
import com.inspur.cams.bpt.base.data.BptPeopleDemobilizedIllness;
import com.inspur.cams.bpt.base.data.BptPeople;
import com.inspur.cams.bpt.base.data.BptPhysicalExamination;
import com.inspur.cams.bpt.base.data.Demobilizedflow;
import com.inspur.cams.bpt.base.domain.IBptApplyDemobilizedDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.PhotoUtil;

/**
 * @title:BptPeopleDemobilizedIllnessCommand
 * @description:维护带病回乡退伍军人
 * @author:
 * @since:2011-05-21
 * @version:1.0
*/
public class BptPeopleDemobilizedIllnessCommand extends BaseAjaxCommand{
	
	IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,
	"bptGroupDomain/bptGroupDomain");
	private BptDemobilizedillCheckDao cdao = (BptDemobilizedillCheckDao) DaoFactory
	.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptDemobilizedillCheckDao");
	/**
	 * 获得在乡复员审批服务接口
	 */
	IBptApplyDemobilizedDomain bptApplyDemobilizedService = ScaComponentFactory.getService(IBptApplyDemobilizedDomain.class,
	"bptApplyDemobilizedDomain/bptApplyDemobilizedDomain");
	/**
	 * 添加人员信息、家庭信息和带病回乡退伍军人信息
	 */
	@Trans
	public void insert() {
		BptPhysicalExaminationDao physicaldao = (BptPhysicalExaminationDao) DaoFactory
		.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPhysicalExaminationDao");
		String ifApplyAdd = (String) getParameter("ifApplyAdd"); // 是否为带病回乡业务受理添加
		String flag = (String) getParameter("flag");
		BaseinfoPeople baseinfopeople = getBaseinfoPeople();
		BaseinfoFamily baseinfofamily = getBaseinfoFamily();
		BptPeopleDemobilizedIllness bptPeopleDemobilizedIllness = getBptPeopleDemobilizedIllness();
		BptPeople bptPeople = getBptPeople();
		
		String peoplePhotoTemp=baseinfopeople.getPhotoTemp();
		String nowTime = DateUtil.getTime();
		String areaCode=baseinfopeople.getRegOrgArea();
		String employeeName=baseinfopeople.getRegPeople();
		dealPhotoC(baseinfopeople, nowTime, areaCode, employeeName,peoplePhotoTemp);//处理照片		
		String applyId = IdHelp.getUUID30();
		if(("UPDATE".equals(idCardValidate(baseinfopeople.getIdCard()))&&"1".equals(flag))
				||("INSERT".equals(idCardValidate(baseinfopeople.getIdCard()))&&!"1".equals(flag))){
			throw new RuntimeException("插入标志不符:"+baseinfopeople.getIdCard()+
					"-"+idCardValidate(baseinfopeople.getIdCard())+"-"+flag);
			
		}
		if(flag.equals("1")){
			String peopleIdRe = IdHelp.getUUID30();
	     	String familyIdRe = IdHelp.getUUID30();
	     	baseinfopeople.setPeopleId(peopleIdRe);
	     	baseinfopeople.setFamilyId(familyIdRe);
	     	baseinfofamily.setFamilyId(familyIdRe);
	     	bptPeople.setPeopleId(peopleIdRe);
	     	bptPeopleDemobilizedIllness.setPeopleId(peopleIdRe);
			service.insertBaseinfo(baseinfopeople, baseinfofamily);
			service.insertPeopleDemobilizedIllness(bptPeopleDemobilizedIllness);
			service.insertBptPeople(bptPeople);
			
		}else{
			service.updateBaseinfo(baseinfopeople, baseinfofamily);
			String peopleId = baseinfopeople.getPeopleId();
			ParameterSet pset = new ParameterSet();
			pset.setParameter("PEOPLE_ID",peopleId);
			if(service.queryBptPeople(pset).getCount()==0){
				service.insertBptPeople(bptPeople);
			}else{
				service.update(bptPeople);
			}
			service.insertPeopleDemobilizedIllness(bptPeopleDemobilizedIllness);
		}
		  setReturn("peopleId", baseinfopeople.getPeopleId());
	      setReturn("familyId", baseinfopeople.getFamilyId());
	     
	  	if ("applyAdd".equals(ifApplyAdd)) { // 带病回乡业务受理添加
			Demobilizedflow demobilizedflow = new Demobilizedflow();
			demobilizedflow.setPeopleId(baseinfopeople.getPeopleId());
			demobilizedflow.setApplyId(applyId);
			demobilizedflow.setCommitFlag("0");
			demobilizedflow.setObjectType("4");// 优抚对象类别设置为“带病回乡”
			demobilizedflow.setServiceYype("45");
			bptApplyDemobilizedService.insert(demobilizedflow);
			setReturn("applyId", demobilizedflow.getApplyId());
		}
	  	Record physicalRecord = new Record();
		physicalRecord.set("applyId", applyId);
		BptPhysicalExamination dataBean=(BptPhysicalExamination)physicalRecord.toBean(BptPhysicalExamination.class);
		physicaldao.insert(dataBean);
		BptDemobilizedillnessCheck cbean= new BptDemobilizedillnessCheck();
		cbean.setApplyId(applyId);
		cbean.setPeopleId(baseinfopeople.getPeopleId());
		cdao.insert(cbean);
	}
	/**
	 * 更新人员信息、优抚信息
	 */
	@Trans
	public void update(){
		Record demobilizedIllnessRecord = (Record) getParameter("DemobilizedIllnessRecord");
		
		String peopleId = demobilizedIllnessRecord.get("peopleId").toString();
		ParameterSet pset = new ParameterSet();
		pset.setParameter("PEOPLE_ID",peopleId);
		BaseinfoPeople baseinfopeople = (BaseinfoPeople)service.queryPeople(pset).getRecord(0).toBean(BaseinfoPeople.class);
		if(demobilizedIllnessRecord.get("demobilizedStateCode")!=null){
			baseinfopeople.setDemobilizedStateCode(demobilizedIllnessRecord.get("demobilizedStateCode").toString());
		}
		if(demobilizedIllnessRecord.get("demobilizedNo")!=null){
			baseinfopeople.setDemobilizedNo(demobilizedIllnessRecord.get("demobilizedNo").toString());
		}
		service.updateBaseinfoPeople(baseinfopeople);
		BptPeopleDemobilizedIllness bptPeopleDemobilizedIllness = getBptPeopleDemobilizedIllness();
		BptPeople bptPeople = getBptPeople();
		service.updateBptPeopleDemobilizedIllness(bptPeopleDemobilizedIllness);
		service.update(bptPeople);
	}
	/**
	 * @description: 获得带病回乡退伍军人信息
	 * @return : BptPeopleDependant
	 */
	private BptPeopleDemobilizedIllness getBptPeopleDemobilizedIllness(){
		Record demobilizedIllnessRecord = (Record) getParameter("DemobilizedIllnessRecord");
		BptPeopleDemobilizedIllness dataBean=(BptPeopleDemobilizedIllness)demobilizedIllnessRecord.toBean(BptPeopleDemobilizedIllness.class);
			dataBean.setPeopleId(demobilizedIllnessRecord.get("peopleId").toString());
			dataBean.setConscriptDate(demobilizedIllnessRecord.get("conscriptDate").toString());
			dataBean.setDecruitmentDate(demobilizedIllnessRecord.get("decruitmentDate").toString());
			dataBean.setForcesNo(demobilizedIllnessRecord.get("forcesNo").toString());
			dataBean.setPosition(demobilizedIllnessRecord.get("position").toString());
			dataBean.setAsdpNo(demobilizedIllnessRecord.get("asdpNo").toString());
			dataBean.setIllessInfo(demobilizedIllnessRecord.get("illessInfo").toString());
			dataBean.setPhysiclalStatus(demobilizedIllnessRecord.get("physiclalStatus").toString());
			dataBean.setFamilyEconomics(demobilizedIllnessRecord.get("familyEconomics").toString());
			dataBean.setApprovalDate(demobilizedIllnessRecord.get("approvalDate").toString());
			dataBean.setCancellationDate(demobilizedIllnessRecord.get("cancellationDate").toString());
			dataBean.setNote(demobilizedIllnessRecord.get("note").toString());
			dataBean.setRegId(BspUtil.getEmpOrganId());
			dataBean.setRegTime(DateUtil.getTime());
			dataBean.setModId(BspUtil.getEmpOrganId());
			dataBean.setModTime(DateUtil.getTime());
		return dataBean;
	}
	
	/**
	 * 获得优抚人员信息
	 */
	private BptPeople getBptPeople(){
		Record demobilizedIllnessRecord = (Record) getParameter("DemobilizedIllnessRecord");
		BptPeople bptPeople=(BptPeople)demobilizedIllnessRecord.toBean(BptPeople.class);
		bptPeople.setPeopleId(demobilizedIllnessRecord.get("peopleId").toString());
		bptPeople.setDemobilizedTyepCode("42");
		bptPeople.setInsanityFlag(demobilizedIllnessRecord.get("insanityFlag").toString());
		bptPeople.setOldLonelyFlag(demobilizedIllnessRecord.get("oldLonelyFlag").toString());
		bptPeople.setWorkAbilityCode(demobilizedIllnessRecord.get("workAbilityCode").toString());
		bptPeople.setWorkAbilityDescribe(demobilizedIllnessRecord.get("workAbilityDescribe").toString());
		bptPeople.setViabilityCode(demobilizedIllnessRecord.get("viabilityCode").toString());
		bptPeople.setSupportPattern(demobilizedIllnessRecord.get("supportPattern").toString());
		bptPeople.setJobStatusDescribe(demobilizedIllnessRecord.get("jobStatusDescribe").toString());
		bptPeople.setBank(demobilizedIllnessRecord.get("bank").toString());
		bptPeople.setAccountCode(demobilizedIllnessRecord.get("accountCode").toString());
		bptPeople.setAccountName(demobilizedIllnessRecord.get("accountName").toString());
		
		
		//将该对象修改为多个对象类别
		ParameterSet param = new ParameterSet();
		param.setParameter("PEOPLE_ID", demobilizedIllnessRecord.get("peopleId").toString());
		DataSet ds =service.queryBptPeople(param);
		if(ds.getCount() !=0){
			Record rd =  ds.getRecord(0);
			
			bptPeople.setDisabilityTypeCode(rd.get("disabilityTypeCode").toString());
			bptPeople.setDependantTypeCode(rd.get("dependantTypeCode").toString());
			bptPeople.setRedaTypeCode(rd.get("redaTypeCode").toString());
			bptPeople.setWarTypeCode(rd.get("warTypeCode").toString());
			bptPeople.setRetiredTypeCode((String)rd.get("retiredTypeCode"));
			bptPeople.setMartyrOffspringCode((String)rd.get("martyrOffspringCode"));
		}else{
			bptPeople.setDisabilityTypeCode("00");
			bptPeople.setDependantTypeCode("00");
			bptPeople.setRedaTypeCode("00");
			bptPeople.setWarTypeCode("00");
			bptPeople.setRetiredTypeCode("00");
			bptPeople.setMartyrOffspringCode("00");
		}
		return bptPeople;
	}
	
	/**
	 *	获取人员信息
	 * author:
	 * since:2011-05-16
	 */
	private BaseinfoPeople getBaseinfoPeople() {
		Record baseinfopeopleRecord = (Record) getParameter("BaseinfoPeopleRecord");
		BaseinfoPeople bean = (BaseinfoPeople) baseinfopeopleRecord.toBean(BaseinfoPeople.class);
		Record PeopleDemobilizedRecord = (Record) getParameter("DemobilizedIllnessRecord");
		bean.setIdCardType("0");
		bean.setDisabilityFlag(baseinfopeopleRecord.get("disabilityFlag").toString());
		bean.setRedaFlag(baseinfopeopleRecord.get("redaFlag").toString());
		bean.setDependantFlag(baseinfopeopleRecord.get("dependantFlag").toString());
		bean.setDemobilizedFlag("1");
		bean.setWarFlag(baseinfopeopleRecord.get("warFlag").toString());
		bean.setDisabilityStateCode(baseinfopeopleRecord.get("disabilityStateCode").toString());
		bean.setRedaStateCode(baseinfopeopleRecord.get("redaStateCode").toString());
		bean.setDependantStateCode(baseinfopeopleRecord.get("dependantStateCode").toString());
		bean.setDemobilizedNo(String.valueOf(PeopleDemobilizedRecord.get("demobilizedNo")));
		bean.setDemobilizedStateCode(PeopleDemobilizedRecord.get("demobilizedStateCode").toString());
		bean.setWarStateCode(baseinfopeopleRecord.get("warStateCode").toString());
		bean.setPersonalStatsTag("0");
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}
	
	/**
	 *	获取家庭信息
	 */
	private BaseinfoFamily getBaseinfoFamily() {
		Record baseinfoPeopleRecord = (Record) getParameter("BaseinfoPeopleRecord");
		BaseinfoFamily bean = new BaseinfoFamily();
		bean.setFamilyId(baseinfoPeopleRecord.get("familyId").toString());
		bean.setFamilyName(baseinfoPeopleRecord.get("name").toString());
		bean.setFamilyCardNo(baseinfoPeopleRecord.get("idCard").toString());
		bean.setDomicileCode(baseinfoPeopleRecord.get("domicileCode").toString());
		bean.setApanageCode(baseinfoPeopleRecord.get("apanageCode").toString());
		bean.setFamilyCardType("0");
		bean.setFamilyStateFlag("0");
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}
	/**
	 *	获取带病回乡审批信息
	 */
	private Demobilizedflow getDemobilizedFlow() {
		Record demobilizedIllnessRecord = (Record) getParameter("DemobilizedIllnessRecord");
		String applyId = IdHelp.getUUID30();
		Demobilizedflow bean = new Demobilizedflow();
		bean.setPeopleId(demobilizedIllnessRecord.get("peopleId").toString());
		bean.setApplyId(applyId);
		bean.setServiceYype("45");
		bean.setCommitFlag("0");
		bean.setObjectType("42");
		return bean;
	}
	
	/**家庭成员
	 * 照片处理(申请人证件照片、申请人现场照片)
	 * @param icmApplyInfo
	 */
	@Trans
	public void dealPhotoC(BaseinfoPeople bean,String nowTime,String areaCode,String employeeName,String peoplePhotoTemp) {
		// 采集证件照片
		String applybase64Code = "";
		String applycardbase64Code = "";
		String applyId = "";
		applybase64Code = bean.getPhotoTemp();
		applycardbase64Code=bean.getCardPhotoTemp();
		if (null != applybase64Code && !"".equals(applybase64Code)) {
			// 保存图片到表 COM_PHOTO 中，并返回该图片的主键
			applyId = PhotoUtil.savePhoto(bean.getPhotoTemp(),bean.getCardPhotoTemp());
		}

		if (applyId != null && !"".equals(applyId)) {
			bean.setPhotoId(applyId);
		}

	}
	public String idCardValidate(String idCard){
		BptPeopleValidateDao dao = (BptPeopleValidateDao) DaoFactory
				.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPeopleValidateDao");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("idCard", idCard);
		DataSet ds = dao.validateBptPeople(pset);
		if(ds.getCount()>0){
			return "UPDATE";
		}else{
			return "INSERT";
		}
	}

}
