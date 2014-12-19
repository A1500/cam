package com.inspur.cams.bpt.manage.cmd;

import java.util.HashMap;
import java.util.Map;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.next.web.cmd.CommandContext;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;
import org.loushang.workflow.api.WfTaskRequestWrapper;

import com.inspur.cams.bpt.base.dao.jdbc.BptPeopleValidateDao;
import com.inspur.cams.bpt.base.data.BptApplyDependant;
import com.inspur.cams.bpt.base.data.BptPeople;
import com.inspur.cams.bpt.base.data.BptPeopleDependant;
import com.inspur.cams.bpt.base.data.WfProcessBusiness;
import com.inspur.cams.bpt.base.domain.IBptApplyDependantDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDependantDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDomain;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.PhotoUtil;

/**
 * @title:BptPeopleDependantCommand
 * @description:遗属信息维护
 * @author:王宝才
 * @since:2011-05-19
 * @version:1.0
*/
public class BptPeopleDependantCommand extends BaseAjaxCommand{
	
	/**
	 * 三属人员申请接口
	 */
	private IBptApplyDependantDomain bptApplyService = ScaComponentFactory.getService(IBptApplyDependantDomain.class,
	"bptApplyDependantDomain/bptApplyDependantDomain");
	
	/**
	 * 工作流信息服务接口
	 */
	IWfProcessBusinessDomain wfProcessBusinessService = ScaComponentFactory.getService(IWfProcessBusinessDomain.class,
	"wfProcessBusinessDomain/wfProcessBusinessDomain");
	
	
	IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,
	"bptGroupDomain/bptGroupDomain");
	
	/**
	 * 获得优抚人员服务接口
	 */
	IBptPeopleDomain bptPeopleService = ScaComponentFactory.getService(IBptPeopleDomain.class,
	"bptPeopleDomain/bptPeopleDomain");	
	
	/**
	 * 添加人员信息、家庭信息和遗属信息
	 */
	@Trans
	public void insert() {
	    String ifApplyAdd = (String) getParameter("ifApplyAdd"); // 是否为三属业务受理添加
		String flag = (String) getParameter("flag");
		BaseinfoPeople baseinfopeople = getBaseinfoPeople();
		BaseinfoFamily baseinfofamily = getBaseinfoFamily();
		BptPeopleDependant bptPeopleDependant = getBptPeopleDependant();
		BptPeople bptPeople = getBptPeople();
		
		String peoplePhotoTemp=baseinfopeople.getPhotoTemp();
		String nowTime = DateUtil.getTime();
		String areaCode=baseinfopeople.getRegOrgArea();
		String employeeName=baseinfopeople.getRegPeople();
		dealPhotoC(baseinfopeople, nowTime, areaCode, employeeName,peoplePhotoTemp);//处理照片
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
	     	bptPeopleDependant.setPeopleId(peopleIdRe);
		   service.insertBaseinfo(baseinfopeople, baseinfofamily);
		   service.insertPeopleDependant(bptPeopleDependant);
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
		   service.insertPeopleDependant(bptPeopleDependant);
		}
		  setReturn("peopleId", baseinfopeople.getPeopleId());
	      setReturn("familyId", baseinfopeople.getFamilyId());
	      
		if("applyAdd".equals(ifApplyAdd)) { // 三属业务受理添加
			   BptApplyDependant bptApplyDependant = new BptApplyDependant();
			   bptApplyDependant.setPeopleId(baseinfopeople.getPeopleId());
			   bptApplyDependant.setApplyId(IdHelp.getUUID30());
			   bptApplyDependant.setCommitFlag("0");
			   bptApplyDependant.setObjectType("2"); // 优抚对象类别设置为“三属”
			   bptApplyService.insert(bptApplyDependant);
			   setReturn("applyId", bptApplyDependant.getApplyId());//
		}     
	}
	
	
	/**
	 * 获得三属信息
	 * @return
	 */
	private BptPeopleDependant getBptPeopleDependant(){
		Record dependantRecord = (Record) getParameter("DependantRecord");
		BptPeopleDependant dataBean=(BptPeopleDependant)dependantRecord.toBean(BptPeopleDependant.class);
		
		dataBean.setPeopleId(dependantRecord.get("peopleId").toString());
		dataBean.setRelationship(dependantRecord.get("relationship").toString());
		dataBean.setLezswName(dependantRecord.get("lezswName").toString());
		dataBean.setLezswSex(dependantRecord.get("lezswSex").toString());
		dataBean.setLezswBirthday(dependantRecord.get("lezswBirthday").toString());
		dataBean.setConscriptDate(dependantRecord.get("conscriptDate").toString());
		dataBean.setWorkUnit(dependantRecord.get("workUnit").toString());
		dataBean.setPosition(dependantRecord.get("position").toString());
		dataBean.setDeathDate(dependantRecord.get("deathDate").toString());
		dataBean.setDeathAddress(dependantRecord.get("deathAddress").toString());
		dataBean.setBuryAddress(dependantRecord.get("buryAddress").toString());
		dataBean.setDeathReason(dependantRecord.get("deathReason").toString());
		dataBean.setLezswApproveDate(dependantRecord.get("lezswApproveDate").toString());
		dataBean.setLezswCertificateId(dependantRecord.get("lezswCertificateId").toString());
		dataBean.setNote(dependantRecord.get("note").toString());
		dataBean.setCheckApproveDate(dependantRecord.get("checkApproveDate").toString());
		dataBean.setCheckAdvice(dependantRecord.get("checkAdvice").toString());
		dataBean.setCheckIncharge(dependantRecord.get("checkIncharge").toString());
		dataBean.setAduitAdvice(dependantRecord.get("aduitAdvice").toString());
		dataBean.setAduitApproveDate(dependantRecord.get("aduitApproveDate").toString());
		dataBean.setAduitIncharge(dependantRecord.get("aduitIncharge").toString());
		dataBean.setVerifyAdvice(dependantRecord.get("verifyAdvice").toString());
		dataBean.setVerifyApproveDate(dependantRecord.get("verifyApproveDate").toString());
		dataBean.setVerifyIncharge(dependantRecord.get("verifyIncharge").toString());
		dataBean.setStudentFlag(dependantRecord.get("studentFlag").toString());
		dataBean.setHolderFlag(dependantRecord.get("holderFlag").toString());
		dataBean.setApprovalDate(dependantRecord.get("approvalDate").toString());
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
		Record dependantRecord = (Record) getParameter("DependantRecord");
		BptPeople bptPeople=(BptPeople)dependantRecord.toBean(BptPeople.class);
			bptPeople.setPeopleId(dependantRecord.get("peopleId").toString());
			bptPeople.setDependantTypeCode(dependantRecord.get("dependantTypeCode").toString());
			bptPeople.setInsanityFlag("0");
			bptPeople.setOldLonelyFlag(dependantRecord.get("oldLonelyFlag").toString());
			bptPeople.setOrphanFlag(dependantRecord.get("orphanFlag").toString());
			bptPeople.setWorkAbilityCode(dependantRecord.get("workAbilityCode").toString());
			bptPeople.setWorkAbilityDescribe(dependantRecord.get("workAbilityDescribe").toString());
			bptPeople.setViabilityCode(dependantRecord.get("viabilityCode").toString());
			bptPeople.setSupportPattern(dependantRecord.get("supportPattern").toString());
			bptPeople.setJobStatusDescribe(dependantRecord.get("jobStatusDescribe").toString());
			bptPeople.setBank(dependantRecord.get("bank").toString());
			bptPeople.setAccountCode(dependantRecord.get("accountCode").toString());
			bptPeople.setAccountName(dependantRecord.get("accountName").toString());
			
			//将该对象修改为多个对象类别
			ParameterSet param = new ParameterSet();
			param.setParameter("PEOPLE_ID", dependantRecord.get("peopleId").toString());
			DataSet ds =service.queryBptPeople(param);
			if(ds.getCount() !=0){
				Record rd =  ds.getRecord(0);
				bptPeople.setDisabilityTypeCode(rd.get("disabilityTypeCode").toString());
				bptPeople.setDemobilizedTyepCode(rd.get("demobilizedTyepCode").toString());
				bptPeople.setRedaTypeCode(rd.get("redaTypeCode").toString());
				bptPeople.setWarTypeCode(rd.get("warTypeCode").toString());
				bptPeople.setRetiredTypeCode((String)rd.get("retiredTypeCode"));
				bptPeople.setMartyrOffspringCode((String)rd.get("martyrOffspringCode"));
			}else{
				bptPeople.setDisabilityTypeCode("00");
				bptPeople.setDemobilizedTyepCode("00");
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
		
		Record dependantRecord = (Record) getParameter("DependantRecord");
		
		BaseinfoPeople bean = (BaseinfoPeople) baseinfopeopleRecord.toBean(BaseinfoPeople.class);
		bean.setIdCardType("0");
		bean.setDisabilityFlag(baseinfopeopleRecord.get("disabilityFlag").toString());
		bean.setRedaFlag(baseinfopeopleRecord.get("redaFlag").toString());
		bean.setDependantFlag("1");
		bean.setDemobilizedFlag(baseinfopeopleRecord.get("demobilizedFlag").toString());
		bean.setWarFlag(baseinfopeopleRecord.get("warFlag").toString());
		bean.setDisabilityStateCode(baseinfopeopleRecord.get("disabilityStateCode").toString());
		bean.setRedaStateCode(baseinfopeopleRecord.get("redaStateCode").toString());
		bean.setDependantStateCode(dependantRecord.get("dependantStateCode").toString());
		bean.setDependantNo(dependantRecord.get("dependantNo").toString());
		bean.setHandicapFlag(dependantRecord.get("handicapFlag").toString());
		bean.setDemobilizedStateCode(baseinfopeopleRecord.get("demobilizedStateCode").toString());
		bean.setWarStateCode(baseinfopeopleRecord.get("warStateCode").toString());
		bean.setPersonalStatsTag("0");
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		
		bean.setDependantNo(dependantRecord.get("dependantNo").toString());//手动添加三属证号 
		
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
	 * 更新三属人员信息
	 */
	@Trans
	public void updateDependant(){
		/**
		 * 获得优抚人员服务接口
		 */
		IBptPeopleDomain bptPeopleService = ScaComponentFactory.getService(IBptPeopleDomain.class,
		"bptPeopleDomain/bptPeopleDomain");	
		
		/**
		 * 获得三属服务接口
		 */
		IBptPeopleDependantDomain dependantService = ScaComponentFactory.getService(IBptPeopleDependantDomain.class,
		"bptPeopleDependantDomain/bptPeopleDependantDomain");	
		
		Record dependantRecord = (Record) getParameter("DependantRecord");
		String peopleId = (String)dependantRecord.get("peopleId");
		ParameterSet pset = getParameterSet();
		pset.clear();
		pset.setParameter("PEOPLE_ID@=", peopleId);
		
		BptPeopleDependant dependant = getUpdateDependant(pset,dependantRecord);
		BptPeople bptPeople = getUpdateBptPeople(pset,dependantRecord);
		BaseinfoPeople baseinfoPeople = getUpdateBaseinfoPeople(pset,dependantRecord);
		
		
		bptPeopleService.update(bptPeople);
		service.updateBaseinfoPeople(baseinfoPeople);
		dependantService.update(dependant);
	}
	
	/**
	 * 获得更新时的人员信息
	 */
	public BaseinfoPeople getUpdateBaseinfoPeople(ParameterSet pset,Record dependantRecord){
		
		DataSet ds = service.queryPeople(pset);
		Record rd = ds.getRecord(0);
		BaseinfoPeople bean = (BaseinfoPeople) rd.toBean(BaseinfoPeople.class);
		bean.setHandicapFlag(dependantRecord.get("handicapFlag").toString());
		bean.setDependantStateCode(dependantRecord.get("dependantStateCode").toString());
		bean.setDependantNo(dependantRecord.get("dependantNo").toString());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}
	
	/**
	 * 获取更新时的类别信息【三属】
	 */
	public BptPeopleDependant getUpdateDependant(ParameterSet pset,Record dependantRecord){
		DataSet ds = service.queryDependantInfo(pset);
		Record rd = ds.getRecord(0);
		BptPeopleDependant dataBean = (BptPeopleDependant)rd.toBean(BptPeopleDependant.class); 
		dataBean.setRelationship(dependantRecord.get("relationship").toString());
		dataBean.setLezswName(dependantRecord.get("lezswName").toString());
		dataBean.setLezswSex(dependantRecord.get("lezswSex").toString());
		dataBean.setLezswBirthday(dependantRecord.get("lezswBirthday").toString());
		dataBean.setConscriptDate(dependantRecord.get("conscriptDate").toString());
		dataBean.setWorkUnit(dependantRecord.get("workUnit").toString());
		dataBean.setPosition(dependantRecord.get("position").toString());
		dataBean.setDeathDate(dependantRecord.get("deathDate").toString());
		dataBean.setDeathAddress(dependantRecord.get("deathAddress").toString());
		dataBean.setDeathReason(dependantRecord.get("deathReason").toString());
		dataBean.setLezswApproveDate(dependantRecord.get("lezswApproveDate").toString());
		dataBean.setLezswCertificateId(dependantRecord.get("lezswCertificateId").toString());
		dataBean.setNote(dependantRecord.get("note").toString());
		dataBean.setCheckApproveDate(dependantRecord.get("checkApproveDate").toString());
		dataBean.setCheckAdvice(dependantRecord.get("checkAdvice").toString());
		dataBean.setCheckIncharge(dependantRecord.get("checkIncharge").toString());
		dataBean.setAduitAdvice(dependantRecord.get("aduitAdvice").toString());
		dataBean.setAduitApproveDate(dependantRecord.get("aduitApproveDate").toString());
		dataBean.setAduitIncharge(dependantRecord.get("aduitIncharge").toString());
		dataBean.setVerifyAdvice(dependantRecord.get("verifyAdvice").toString());
		dataBean.setVerifyApproveDate(dependantRecord.get("verifyApproveDate").toString());
		dataBean.setVerifyIncharge(dependantRecord.get("verifyIncharge").toString());
		dataBean.setStudentFlag(dependantRecord.get("studentFlag").toString());
		dataBean.setHolderFlag(dependantRecord.get("holderFlag").toString());
		dataBean.setApprovalDate(dependantRecord.get("approvalDate").toString());
		dataBean.setModId(BspUtil.getEmpOrganId());
		dataBean.setModTime(DateUtil.getTime());
		return dataBean;
	}
	
	/**
	 * 获得更新时的优抚信息
	 */
	public  BptPeople getUpdateBptPeople(ParameterSet pset,Record dependantRecord){
		DataSet ds = bptPeopleService.query(pset);
		Record rd = ds.getRecord(0);
		BptPeople dataBean = (BptPeople)rd.toBean(BptPeople.class); 
		dataBean.setDependantTypeCode(dependantRecord.get("dependantTypeCode").toString());
		dataBean.setOldLonelyFlag(dependantRecord.get("oldLonelyFlag").toString());
		dataBean.setOrphanFlag(dependantRecord.get("orphanFlag").toString());
		dataBean.setWorkAbilityCode(dependantRecord.get("workAbilityCode").toString());
		dataBean.setViabilityCode(dependantRecord.get("viabilityCode").toString());
		dataBean.setSupportPattern(dependantRecord.get("supportPattern").toString());
		dataBean.setJobStatusDescribe(dependantRecord.get("jobStatusDescribe").toString());
		dataBean.setBank(dependantRecord.get("bank").toString());
		dataBean.setAccountCode(dependantRecord.get("accountCode").toString());
		dataBean.setAccountName(dependantRecord.get("accountName").toString());
		return dataBean;
	}
	
	/**
	 * 根据牺牲病故证书字号查询出烈士信息
	 */
	public void queryLezsw(){
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryDependantInfo(pset);
		Record rd = ds.getRecord(0);
		
		if(rd.get("lezswName") != null){
			String lezswName = rd.get("lezswName").toString();
			setReturn("lezswName", lezswName);
		}
		
		if(rd.get("lezswSex") != null){
			String lezswSex = rd.get("lezswSex").toString();
			setReturn("lezswSex", lezswSex);
		}
		
		if(rd.get("lezswBirthday") != null){
			String lezswBirthday = rd.get("lezswBirthday").toString();
			setReturn("lezswBirthday", lezswBirthday);
		}
		
		
		if(rd.get("conscriptDate") != null){
			String conscriptDate = rd.get("conscriptDate").toString();
			setReturn("conscriptDate", conscriptDate);
		}
		
		if(rd.get("workUnit") != null){
			String workUnit = rd.get("workUnit").toString();
			setReturn("workUnit", workUnit);
		}
		
		if(rd.get("position") != null){
			String position = rd.get("position").toString();
			setReturn("position", position);
		}
		
		if(rd.get("deathDate") != null){
			String deathDate = rd.get("deathDate").toString();
			setReturn("deathDate", deathDate);
		}
		
		if(rd.get("deathAddress") != null){
			String deathAddress = rd.get("deathAddress").toString();
			setReturn("deathAddress", deathAddress);
		}
		
		if(rd.get("lezswApproveDate") != null){
			String lezswApproveDate = rd.get("lezswApproveDate").toString();
			setReturn("lezswApproveDate", lezswApproveDate);
		}
		
		if(rd.get("deathReason") != null){
			String deathReason = rd.get("deathReason").toString();
			setReturn("deathReason", deathReason);
		}
	}
	
	/**
	 * 创建并发起三属申请流程
	 */
	@Trans
	public void createAndSend() { 
		String peopleId = (String)getParameter("peopleId");
		String applyId = (String)getParameter("applyId");
		
		//修改三属申请流程信息表
		BptApplyDependant bptApplyDependant = new BptApplyDependant();
		bptApplyDependant.setApplyId(applyId);
		bptApplyDependant.setPeopleId(peopleId);
		bptApplyDependant.setCommitFlag("1");
		bptApplyDependant.setObjectType("2");
		bptApplyDependant.setApproveDate(DateUtil.getDay());
		bptApplyDependant.setApproveOrganId(BspUtil.getCorpOrgan().getOrganName());
		bptApplyDependant.setServiceType("21");
		bptApplyService.update(bptApplyDependant);
		
		//调用BPM接口发起流程
		CommandContext.setContextParameter("procDefUniqueId", "8a898b4a31a892c20131a892c25a0000");
		CommandContext.setContextParameter("startActDefUniqueId","8a898b5f31a88d200131a89c55910009");
		Map<String,String>  context = new HashMap<String,String>();
		String corpStruId = BspUtil.getCorpStruId();
		String currentOrganName =  BspUtil.getCorpOrgan().getOrganName();
		context.put("dependant_cityApprove", corpStruId);
		Map<String,String> map=WfTaskRequestWrapper.getInstance().createAndSend(applyId, currentOrganName+"的三属业务申请", context);
		String processId = map.get("processId");
		  
		//添加工作流信息表
		WfProcessBusiness wfProcessBusiness = new WfProcessBusiness();
		wfProcessBusiness.setProcessId(processId);
		wfProcessBusiness.setBusinessId(applyId);
		wfProcessBusiness.setConnectId(peopleId);
		wfProcessBusiness.setBusinessType("21");
		wfProcessBusinessService.insert(wfProcessBusiness);
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
