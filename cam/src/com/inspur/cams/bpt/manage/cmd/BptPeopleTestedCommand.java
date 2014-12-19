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
import com.inspur.cams.bpt.base.dao.jdbc.BptPhysicalExaminationDao;
import com.inspur.cams.bpt.base.data.BptApplyDependant;
import com.inspur.cams.bpt.base.data.BptPeople;
import com.inspur.cams.bpt.base.data.BptPeopleTested;
import com.inspur.cams.bpt.base.data.BptPhysicalExamination;
import com.inspur.cams.bpt.base.data.WfProcessBusiness;
import com.inspur.cams.bpt.base.domain.IBptApplyDependantDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleTestedDomain;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.PhotoUtil;

/**
 * @title:BptPeopleTestedCommand
 * @description:
 * @author:
 * @since:2011-05-14
 * @version:1.0
 */
public class BptPeopleTestedCommand extends BaseAjaxCommand {
	private IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class, "bptGroupDomain/bptGroupDomain");

	
	/**
	 * 工作流信息服务接口
	 */
	IWfProcessBusinessDomain wfProcessBusinessService = ScaComponentFactory.getService(IWfProcessBusinessDomain.class,
	"wfProcessBusinessDomain/wfProcessBusinessDomain");
	
	
	/**
	 * 参战申请接口
	 */
	private IBptApplyDependantDomain bptApplyService = ScaComponentFactory.getService(IBptApplyDependantDomain.class,
	"bptApplyDependantDomain/bptApplyDependantDomain");
	//删除参战参试
	@Trans
	public void deleteWarOrTest(){
		Record[] records = (Record[]) getParameter("record");
		String warOrTest = (String) getParameter("warOrTest");
		for (Record record : records) {
			String applyId =(String)record.get("APPLY_ID");
			String peopleId =(String)record.get("PEOPLE_ID");
			ParameterSet pst = new ParameterSet();
			pst.setParameter("applyId", applyId);
			pst.setParameter("peopleId", peopleId);
			pst.setParameter("warOrTest", warOrTest);
			bptApplyService.deleteDependant(pst);
		}
		
	}
	
	/**
	 * 功能:
	 * author:
	 * day:
	 */
	@Trans
	public void insert() {
		BptPhysicalExaminationDao physicaldao = (BptPhysicalExaminationDao) DaoFactory
		.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPhysicalExaminationDao");
		String ifApplyAdd = (String) getParameter("ifApplyAdd"); // 是否为业务申请
		String flag = (String) getParameter("flag");
		BaseinfoPeople baseinfopeople = getBaseinfoPeople();
		BaseinfoFamily baseinfofamily = getBaseinfoFamily();
		BptPeople bptPeople = getBptPeople();
		BptPeopleTested bptPeopleTested = getBptPeopleTested();
		
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
	     	bptPeopleTested.setPeopleId(peopleIdRe);
			service.insertBaseinfo(baseinfopeople, baseinfofamily);
			service.insertBptPeople(bptPeople);
			service.insertTested(bptPeopleTested);
			
		}else{
			baseinfopeople.setWarStateCode("1");
			service.updateBaseinfo(baseinfopeople, baseinfofamily);
			
			ParameterSet pset = new ParameterSet();
			pset.setParameter("PEOPLE_ID", bptPeople.getPeopleId());
			if (service.queryBptPeople(pset).getCount() == 0) {
				service.insertBptPeople(bptPeople);
			} else {
				service.update(bptPeople);
			}
			
			service.insertTested(bptPeopleTested);
		}
		setReturn("peopleId", baseinfopeople.getPeopleId());
	    setReturn("familyId", baseinfopeople.getFamilyId());
		
		if("applyAdd".equals(ifApplyAdd)) {
			 BptApplyDependant bptApplyDependant = new BptApplyDependant();
		     bptApplyDependant.setPeopleId(baseinfopeople.getPeopleId());
		     bptApplyDependant.setApplyId(applyId);
		     bptApplyDependant.setCommitFlag("0");
		     bptApplyDependant.setObjectType("6"); // 设置优抚对象类别为“参试”
		     bptApplyService.insert(bptApplyDependant);
		     setReturn("applyId",bptApplyDependant.getApplyId());
		}
		Record physicalRecord = new Record();
		physicalRecord.set("applyId", applyId);
		BptPhysicalExamination dataBean=(BptPhysicalExamination)physicalRecord.toBean(BptPhysicalExamination.class);
		physicaldao.insert(dataBean);
   }

	/**
	 * 修改参试人员信息
	 */
	@Trans
	public void updateTested() {
		/**
		 * 获得参战人员服务接口
		 */
		IBptPeopleTestedDomain iBptPeopleTestedService = ScaComponentFactory.getService(IBptPeopleTestedDomain.class,"bptPeopleTestedDomain/bptPeopleTestedDomain");
		
		/**
		 * 获得优抚人员服务接口
		 */
		IBptPeopleDomain bptPeopleService = ScaComponentFactory.getService(IBptPeopleDomain.class,
		"bptPeopleDomain/bptPeopleDomain");	
		
		BptPeopleTested bPeopleTested = getBptPeopleTested();
		BptPeople bptPeople = getBptPeople();
		BaseinfoPeople baseinfoPeople = getUpdateBaseinfoPeople();
		
		iBptPeopleTestedService.updatePeopleTeseted(bPeopleTested);
		bptPeopleService.update(bptPeople);
		
	//	service.updateWar(bptPeopleWar);
	//	service.update(bptPeople);
		service.updateBaseinfoPeople(baseinfoPeople);
	}
	
	
	/**
	 *	获取人员信息
	 * author:
	 * since:2011-05-16
	 */
	private BaseinfoPeople getBaseinfoPeople() {
		Record tEntity = (Record) getParameter("testedEntity");
		Record baseinfopeopleRecord = (Record) getParameter("BaseinfoPeopleRecord");
		BaseinfoPeople bean = (BaseinfoPeople) baseinfopeopleRecord.toBean(BaseinfoPeople.class);
		bean.setIdCardType("0");
		bean.setDisabilityFlag(baseinfopeopleRecord.get("disabilityFlag").toString());
		bean.setRedaFlag(baseinfopeopleRecord.get("redaFlag").toString());
		bean.setDependantFlag(baseinfopeopleRecord.get("dependantFlag").toString());
		bean.setDemobilizedFlag(baseinfopeopleRecord.get("demobilizedFlag").toString());
		bean.setWarFlag("1");
		bean.setDisabilityStateCode(baseinfopeopleRecord.get("disabilityStateCode").toString());
		bean.setRedaStateCode(baseinfopeopleRecord.get("redaStateCode").toString());
		bean.setDependantStateCode(baseinfopeopleRecord.get("dependantStateCode").toString());
		bean.setDemobilizedStateCode(baseinfopeopleRecord.get("demobilizedStateCode").toString());
        bean.setWarStateCode(tEntity.get("warStateCode").toString());
		bean.setWarNo(tEntity.get("warNo").toString());

		bean.setPersonalStatsTag("0");
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}
	/**
	 * 获得优抚人员信息
	 */
	private BptPeople getBptPeople(){
		Record testedEntity = (Record) getParameter("testedEntity");
		BptPeople bptPeople=(BptPeople)testedEntity.toBean(BptPeople.class);
			bptPeople.setPeopleId(testedEntity.get("peopleId").toString());
			bptPeople.setWarTypeCode("61");
			bptPeople.setInsanityFlag(testedEntity.get("insanityFlag").toString());
			bptPeople.setOldLonelyFlag(testedEntity.get("oldLonelyFlag").toString());
			bptPeople.setWorkAbilityCode(testedEntity.get("workAbilityCode").toString());
			bptPeople.setWorkAbilityDescribe(testedEntity.get("workAbilityDescribe").toString());
			bptPeople.setViabilityCode(testedEntity.get("viabilityCode").toString());
			bptPeople.setSupportPattern(testedEntity.get("supportPattern").toString());
			bptPeople.setJobStatusDescribe(testedEntity.get("jobStatusDescribe").toString());
			bptPeople.setBank(testedEntity.get("bank").toString());
			bptPeople.setAccountCode(testedEntity.get("accountCode").toString());
			bptPeople.setAccountName(testedEntity.get("accountName").toString());
			//将该对象修改为多个对象类别
			ParameterSet param = new ParameterSet();
			param.setParameter("PEOPLE_ID", testedEntity.get("peopleId").toString());
			DataSet ds =service.queryBptPeople(param);
			if(ds.getCount()!=0){
				Record rd =  ds.getRecord(0);
				bptPeople.setDisabilityTypeCode(rd.get("disabilityTypeCode").toString());
				bptPeople.setDependantTypeCode(rd.get("dependantTypeCode").toString());
				bptPeople.setRedaTypeCode(rd.get("redaTypeCode").toString());
			    bptPeople.setDemobilizedTyepCode(rd.get("demobilizedTyepCode").toString());
			    bptPeople.setRetiredTypeCode((String)rd.get("retiredTypeCode"));
				bptPeople.setMartyrOffspringCode((String)rd.get("martyrOffspringCode"));
			}else{
				bptPeople.setDisabilityTypeCode("00");
				bptPeople.setDependantTypeCode("00");
				bptPeople.setRedaTypeCode("00");
			    bptPeople.setDemobilizedTyepCode("00");
			    bptPeople.setRetiredTypeCode("00");
				bptPeople.setMartyrOffspringCode("00");
		    }
		return bptPeople;
	}
	/**
	 *	获取家庭信息
	 */
	private BaseinfoFamily getBaseinfoFamily() {
		Record baseinfoPeopleRecord = (Record) getParameter("BaseinfoPeopleRecord");
		//BaseinfoFamily bean = (BaseinfoFamily) baseinfofamilyRecord.toBean(BaseinfoFamily.class);
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
	 *  获取参试信息
	 */
	private BptPeopleTested getBptPeopleTested(){
		Record rd =(Record)getParameter("testedEntity");
		BptPeopleTested bean = (BptPeopleTested) rd.toBean(BptPeopleTested.class);
		bean.setPeopleId(rd.get("peopleId").toString());
//		bean.setApprovalDate(DateUtil.getDay());
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
//		bean.setCancellationDate(DateUtil.getDay());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;

	}
	
	/**
	 *  获取修改人员信息
	 */
	
	private BaseinfoPeople getUpdateBaseinfoPeople(){
		Record recordTested = (Record) getParameter("testedEntity");
		String peopleId = (String) recordTested.get("peopleId");
		ParameterSet pSet = getParameterSet();
		pSet.clear();
		pSet.setParameter("PEOPLE_ID@=", peopleId);
		DataSet dSet = service.queryPeople(pSet);
		Record rd = dSet.getRecord(0);
		
		BaseinfoPeople bean = (BaseinfoPeople)rd.toBean(BaseinfoPeople.class);
		bean.setWarNo(recordTested.get("warNo").toString());
		bean.setWarStateCode(recordTested.get("warStateCode").toString());
	
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}
	
	/**
	 * 发起参试退役人员身份认定申请
	 */
	@Trans
	public void createAndSend() {
		String applyId = (String)getParameter("applyId");
		String peopleId = (String)getParameter("peopleId");
		
		// 修改参战退役人员审批信息
		BptApplyDependant bptApplyDependant = new BptApplyDependant();
		bptApplyDependant.setPeopleId(peopleId);
		bptApplyDependant.setApplyId(applyId);
		bptApplyDependant.setCommitFlag("1");
		bptApplyDependant.setObjectType("6");
		bptApplyDependant.setApproveDate(DateUtil.getDay());
		bptApplyDependant.setApproveOrganId(BspUtil.getCorpOrgan().getOrganName());
		bptApplyDependant.setServiceType("61");
		bptApplyService.update(bptApplyDependant);
		
		//调用BPM接口发起流程
		CommandContext.setContextParameter("procDefUniqueId", "8a898b4a31e508470131e508471a0000");
		CommandContext.setContextParameter("startActDefUniqueId","8a898b5f31e503cf0131e512669d000f");
		Map<String,String> context = new HashMap<String,String>();
		String corpStruId = BspUtil.getCorpStruId();
		String currentOrganName = BspUtil.getCorpOrgan().getOrganName();
		context.put("tested_approveCity", corpStruId);
		Map<String,String> map = WfTaskRequestWrapper.getInstance().createAndSend(applyId, currentOrganName+"的参试退役军人身份认定申请", context);
		String processId = map.get("processId");
		
		//添加工作流信息表
		WfProcessBusiness wfProcessBusiness = new WfProcessBusiness();
		wfProcessBusiness.setProcessId(processId);
		wfProcessBusiness.setBusinessId(applyId);
		wfProcessBusiness.setConnectId(peopleId);
		wfProcessBusiness.setBusinessType("61");
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
