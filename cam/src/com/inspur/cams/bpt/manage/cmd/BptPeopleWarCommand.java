package com.inspur.cams.bpt.manage.cmd;

import java.math.BigDecimal;
import java.util.*;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;
import org.loushang.workflow.api.WfTaskRequestWrapper;

import com.inspur.cams.bpt.base.dao.jdbc.BptPeopleValidateDao;
import com.inspur.cams.bpt.base.dao.jdbc.BptPeopleWarDao;
import com.inspur.cams.bpt.base.data.BptApplyDependant;
import com.inspur.cams.bpt.base.data.BptPeople;
import com.inspur.cams.bpt.base.data.BptPeopleDependant;
import com.inspur.cams.bpt.base.data.BptPeopleDisability;
import com.inspur.cams.bpt.base.data.BptPeopleTested;
import com.inspur.cams.bpt.base.data.BptPeopleWar;
import com.inspur.cams.bpt.base.data.BptStateChange;
import com.inspur.cams.bpt.base.data.WfProcessBusiness;
import com.inspur.cams.bpt.base.domain.IBptApplyDependantDomain;
import com.inspur.cams.bpt.base.domain.IBptComfortNoDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDependantDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDisabilityDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleTestedDomain;
import com.inspur.cams.bpt.base.domain.IBptStateChangeDomain;
import com.inspur.cams.bpt.base.domain.IWarDomain;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;
import com.inspur.cams.bpt.base.domain.support.BptComfortNoDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.PhotoUtil;

import org.loushang.bsp.id.util.MaxValueUtil;

/**
 * @title:BptPeopleWarCommand
 * @description:
 * @author:
 * @since:2011-05-12
 * @version:1.0
*/
public class BptPeopleWarCommand extends BaseAjaxCommand{
	IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,"bptGroupDomain/bptGroupDomain");
	// 状态变更接口
	private IBptStateChangeDomain stateChangeService = ScaComponentFactory
			.getService(IBptStateChangeDomain.class,
					"bptStateChangeDomain/bptStateChangeDomain");
	/**
	 * 工作流信息服务接口
	 */
	IWfProcessBusinessDomain wfProcessBusinessService = ScaComponentFactory.getService(IWfProcessBusinessDomain.class,
	"wfProcessBusinessDomain/wfProcessBusinessDomain");
	
	IBptComfortNoDomain NOService = ScaComponentFactory.getService(BptComfortNoDomain.class,"bptComfortNoDomain/bptComfortNoDomain");
	

	/**
	 * 参战申请接口
	 */
	private IBptApplyDependantDomain bptApplyService = ScaComponentFactory.getService(IBptApplyDependantDomain.class,
	"bptApplyDependantDomain/bptApplyDependantDomain");
	
	IBptPeopleTestedDomain bptPeopleTestedService = ScaComponentFactory.getService(IBptPeopleTestedDomain.class,"bptPeopleTestedDomain/bptPeopleTestedDomain");
	
	/**
	 * 三属服务接口
	 */
	IBptPeopleDependantDomain dependantService = ScaComponentFactory.getService(IBptPeopleDependantDomain.class,
	"bptPeopleDependantDomain/bptPeopleDependantDomain");
	
	IWarDomain iWarService = ScaComponentFactory.getService(IWarDomain.class,"bptWarDomain/bptWarDomain");
	
	/**
	 * 功能:
	 * author:
	 * day:
	 */
	@Trans
	public void insert(){
		String ifApplyAdd = (String) getParameter("ifApplyAdd"); // 是否为参战业务受理添加
		String applyId = (String) getParameter("applyId"); 
		String flag = (String) getParameter("flag");
		BaseinfoPeople baseinfopeople = getBaseinfoPeople();
		BptPeopleWar bptPeopleWar = getBptPeopleWar();
		BaseinfoFamily baseinfofamily = getBaseinfoFamily();
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
	     	bptPeopleWar.setPeopleId(peopleIdRe);
		   service.insert(bptPeopleWar);
		   service.insertBaseinfo(baseinfopeople, baseinfofamily);
		   service.insertBptPeople(bptPeople);
		}else{
			baseinfopeople.setWarStateCode("1");
		   service.updateBaseinfo(baseinfopeople, baseinfofamily);
		   String peopleId = baseinfopeople.getPeopleId();
			ParameterSet pset = new ParameterSet();
			pset.setParameter("PEOPLE_ID",peopleId);
			if(service.queryBptPeople(pset).getCount()==0){
				service.insertBptPeople(bptPeople);
			}else{
				service.update(bptPeople);
			}
		   service.insert(bptPeopleWar);
		}
		setReturn("peopleId", baseinfopeople.getPeopleId());
		setReturn("familyId", baseinfopeople.getFamilyId());
		
		if("applyAdd".equals(ifApplyAdd)) { // 参战业务受理添加
			   BptApplyDependant bptApplyDependant = new BptApplyDependant();
			   bptApplyDependant.setPeopleId(baseinfopeople.getPeopleId());
			   bptApplyDependant.setApplyId(applyId);
			   bptApplyDependant.setCommitFlag("0");
			   bptApplyDependant.setObjectType("5"); // 设置优抚对象类别为“参战”
			   bptApplyService.insert(bptApplyDependant);
			   setReturn("applyId", bptApplyDependant.getApplyId());
	    }
    }
	
	
	/**
	 * 更新参战人员信息
	 */
	@Trans
	public void updateWar(){
		/**
		 * 获得参战人员服务接口
		 */
		IWarDomain iWarService = ScaComponentFactory.getService(IWarDomain.class,"bptWarDomain/bptWarDomain");
		
		/**
		 * 获得优抚人员服务接口
		 */
		IBptPeopleDomain bptPeopleService = ScaComponentFactory.getService(IBptPeopleDomain.class,
		"bptPeopleDomain/bptPeopleDomain");	
		
		BptPeopleWar bptPeopleWar = getBptPeopleWar();
		BptPeople bptPeople = getBptPeople();
		BaseinfoPeople baseinfoPeople = getUpdateBaseinfoPeople();
		
		iWarService.updateWar(bptPeopleWar);
		bptPeopleService.update(bptPeople);
		
	//	service.updateWar(bptPeopleWar);
	//	service.update(bptPeople);
		service.updateBaseinfoPeople(baseinfoPeople);
	}
	
	/**
	 *  删除
	 */
	@Trans
	public void delete(){
		/**
		 * 获得参战人员服务接口
		 */
		IWarDomain iWarService = ScaComponentFactory.getService(IWarDomain.class,"bptWarDomain/bptWarDomain");
		
		Record delRecord = (Record) getParameter("delIds");
		String peopleId = delRecord.get("PEOPLE_ID").toString();
		ParameterSet pSet = getParameterSet();
		pSet.clear();
		pSet.setParameter("PEOPLE_ID@=", peopleId);
		
		
	}
	
	/**
	 *	获取人员信息
	 * author:
	 * since:2011-05-16
	 */
	private BaseinfoPeople getBaseinfoPeople() {
		Record warred = (Record) getParameter("warEntity");
		Record baseinfopeopleRecord = (Record) getParameter("BaseinfoPeopleRecord");
		BaseinfoPeople bean = (BaseinfoPeople) baseinfopeopleRecord.toBean(BaseinfoPeople.class);
		bean.setIdCardType("0");
		bean.setPeopleId(baseinfopeopleRecord.get("peopleId").toString());
     	bean.setFamilyId(baseinfopeopleRecord.get("familyId").toString());
		bean.setDisabilityFlag(baseinfopeopleRecord.get("disabilityFlag").toString());
		bean.setRedaFlag(baseinfopeopleRecord.get("redaFlag").toString());
		bean.setDependantFlag(baseinfopeopleRecord.get("dependantFlag").toString());
		bean.setDemobilizedFlag(baseinfopeopleRecord.get("demobilizedFlag").toString());
		bean.setWarFlag("1");
		bean.setDisabilityStateCode(baseinfopeopleRecord.get("disabilityStateCode").toString());
		bean.setRedaStateCode(baseinfopeopleRecord.get("redaStateCode").toString());
		bean.setDependantStateCode(baseinfopeopleRecord.get("dependantStateCode").toString());
		bean.setDemobilizedStateCode(baseinfopeopleRecord.get("demobilizedStateCode").toString());
        bean.setWarStateCode(warred.get("warStateCode").toString());
		bean.setWarNo(warred.get("warNo").toString());
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
		Record warEntity = (Record) getParameter("warEntity");
		BptPeople bptPeople=(BptPeople)warEntity.toBean(BptPeople.class);
			bptPeople.setPeopleId(warEntity.get("peopleId").toString());
			bptPeople.setWarTypeCode("51");
			bptPeople.setInsanityFlag(warEntity.get("insanityFlag").toString());
			bptPeople.setOldLonelyFlag(warEntity.get("oldLonelyFlag").toString());
			bptPeople.setWorkAbilityCode(warEntity.get("workAbilityCode").toString());
			bptPeople.setWorkAbilityDescribe((String)warEntity.get("workAbilityDescribe"));
			bptPeople.setViabilityCode(warEntity.get("viabilityCode").toString());
			bptPeople.setSupportPattern(warEntity.get("supportPattern").toString());
			bptPeople.setJobStatusDescribe((String)warEntity.get("jobStatusDescribe"));
			bptPeople.setBank(warEntity.get("bank").toString());
			bptPeople.setAccountCode(warEntity.get("accountCode").toString());
			bptPeople.setAccountName(warEntity.get("accountName").toString());
			
			//将该对象修改为多个对象类别
			ParameterSet param = new ParameterSet();
			param.setParameter("PEOPLE_ID", warEntity.get("peopleId").toString());
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
	 *  获取参战人员信息
	 */
	private BptPeopleWar getBptPeopleWar(){
		Record bptpeoplewarRecord = (Record) getParameter("warEntity");
		BptPeopleWar bean = (BptPeopleWar) bptpeoplewarRecord.toBean(BptPeopleWar.class);
		bean.setPeopleId(bptpeoplewarRecord.get("peopleId").toString());
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
		
	}
	
	/**
	 * 获取修改人员信息
	 */
	private BaseinfoPeople getUpdateBaseinfoPeople() {
		Record baseInfoRecord = (Record) getParameter("warEntity");
		String peopleId = (String) baseInfoRecord.get("peopleId");
		ParameterSet pSet = getParameterSet();
		pSet.clear();
		pSet.setParameter("PEOPLE_ID@=", peopleId);
		DataSet dSet = service.queryPeople(pSet);
		Record rd = dSet.getRecord(0);
		
		BaseinfoPeople bean = (BaseinfoPeople)rd.toBean(BaseinfoPeople.class);
		bean.setWarNo(baseInfoRecord.get("warNo").toString());
		bean.setWarStateCode(baseInfoRecord.get("warStateCode").toString());
		
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}
	
	/**
	 * 发起参战退役人员身份认定申请
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
		bptApplyDependant.setObjectType("5");
		bptApplyDependant.setApproveDate(DateUtil.getDay());
		bptApplyDependant.setApproveOrganId(BspUtil.getCorpOrgan().getOrganName());
		bptApplyDependant.setServiceType("51");
		bptApplyService.update(bptApplyDependant);
		
		//调用BPM接口发起流程
		CommandContext.setContextParameter("procDefUniqueId", "8a898b4a31d6b4680131d6cd22f00022");
		CommandContext.setContextParameter("startActDefUniqueId","8a898b5f31d6c6220131d6d24eb0000b");
		Map<String,String> context = new HashMap<String,String>();
		String corpStruId = BspUtil.getCorpStruId();
		String currentOrganName = BspUtil.getCorpOrgan().getOrganName();
		context.put("war_approveCity", corpStruId);
		Map<String,String> map = WfTaskRequestWrapper.getInstance().createAndSend(applyId, currentOrganName+"的参战退役军人身份认定申请", context);
		String processId = map.get("processId");
		
		//添加工作流信息表
		WfProcessBusiness wfProcessBusiness = new WfProcessBusiness();
		wfProcessBusiness.setProcessId(processId);
		wfProcessBusiness.setBusinessId(applyId);
		wfProcessBusiness.setConnectId(peopleId);
		wfProcessBusiness.setBusinessType("51");
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
	/**
	 * 确认人员信息,修改提交标志
	 * @param 
	 */
	@Trans
	public void sureWar(){
		String applyId = (String)getParameter("applyId");
		ParameterSet pst = new ParameterSet();
		pst.setParameter("APPLY_ID", applyId);
		DataSet ds = bptApplyService.queryApplyDependant(pst);
		if(ds.getCount()>0){
			Record record = ds.getRecord(0);
			BptApplyDependant bw =(BptApplyDependant)record.toBean(BptApplyDependant.class);
			bw.setApproveDate(DateUtil.getDay());
			bw.setCommitFlag("1");
			bptApplyService.update(bw);
			//更新优抚证号
			String peopleId =(String)record.get("peopleId");
			ParameterSet pset = new ParameterSet();
			pset.setParameter("people_id", peopleId);
			DataSet bptdataset=service.queryBptPeople(pset);
			DataSet peopledataset =service.queryPeople(pset);
			DataSet depandentdataset=dependantService.query(pset);
			DataSet wardataset=iWarService.query(pset);
			DataSet testdataset=bptPeopleTestedService.queryPeopleTested(pset);
			if(peopledataset.getCount()==1&&bptdataset.getCount()==1){
				Record r=peopledataset.getRecord(0);
				BaseinfoPeople baseinfoPeople =(BaseinfoPeople)r.toBean(BaseinfoPeople.class);
				String dependantTypeCode =(String)bptdataset.getRecord(0).get("dependantTypeCode");
				String warTypeCode =(String)bptdataset.getRecord(0).get("warTypeCode");
				String no;
				String domicileCode=(String)r.get("domicileCode");
				String isApprove =(String)record.get("isApprove");
				String isSure =(String)record.get("isSure");
				if("21".equals(dependantTypeCode)&&depandentdataset.getCount()==1){
					
					if("0".equals(isApprove)&&"1".equals(isSure)){
						r.set("dependantNo", NOService.getNO("LS",domicileCode));
						r.set("dependantStateCode","2");
						insertStateChange(baseinfoPeople,"1","2","21");
						
					}else if("0".equals(isApprove)&&"0".equals(isSure)){
						r.set("dependantNo", NOService.getNO("LS",domicileCode));
						r.set("dependantStateCode","3");
						insertStateChange(baseinfoPeople,"1","3","21");
					}else{
						r.set("dependantStateCode","6");
						insertStateChange(baseinfoPeople,"1","6","21");
					}
					Record depandentRrcord =depandentdataset.getRecord(0);
					depandentRrcord.set("approvalDate", DateUtil.getDay());
					BptPeopleDependant Dependant =(BptPeopleDependant)depandentRrcord.toBean(BptPeopleDependant.class);
					dependantService.update(Dependant);
					
				}
				else if("22".equals(dependantTypeCode)&&depandentdataset.getCount()==1){
					if("0".equals(isApprove)&&"1".equals(isSure)){
						r.set("dependantNo", NOService.getNO("YG",domicileCode));
						r.set("dependantStateCode","2");
						
					}else if("0".equals(isApprove)&&"0".equals(isSure)){
						r.set("dependantNo", NOService.getNO("YG",domicileCode));
						r.set("dependantStateCode","3");
					}else{
						r.set("dependantStateCode","6");
					}
					
					Record depandentRrcord =depandentdataset.getRecord(0);
					depandentRrcord.set("approvalDate", DateUtil.getDay());
					BptPeopleDependant Dependant =(BptPeopleDependant)depandentRrcord.toBean(BptPeopleDependant.class);
					dependantService.update(Dependant);
				}
				else if("23".equals(dependantTypeCode)&&depandentdataset.getCount()==1){
					if("0".equals(isApprove)&&"1".equals(isSure)){
						r.set("dependantNo", NOService.getNO("BG",domicileCode));
						r.set("dependantStateCode","2");
					}else if("0".equals(isApprove)&&"0".equals(isSure)){
						r.set("dependantNo", NOService.getNO("BG",domicileCode));
						r.set("dependantStateCode","3");
					}else{
						r.set("dependantStateCode","6");
					}
					Record depandentRrcord =depandentdataset.getRecord(0);
					depandentRrcord.set("approvalDate", DateUtil.getDay());
					BptPeopleDependant Dependant =(BptPeopleDependant)depandentRrcord.toBean(BptPeopleDependant.class);
					dependantService.update(Dependant);
					
				}
				else if("51".equals(warTypeCode)&&wardataset.getCount()==1){
					if("0".equals(isApprove)&&"1".equals(isSure)){
						r.set("warNo", NOService.getNO("CZ",domicileCode));
						r.set("warStateCode", "2");
						insertStateChange(baseinfoPeople,"1","2","51");
					}else if("0".equals(isApprove)&&"0".equals(isSure)){
						r.set("warNo", NOService.getNO("CZ",domicileCode));
						r.set("warStateCode", "3");
						insertStateChange(baseinfoPeople,"1","3","51");
					}else{
						r.set("warStateCode", "6");
						insertStateChange(baseinfoPeople,"1","6","51");
					}
					Record warRrcord =wardataset.getRecord(0);
					warRrcord.set("approvalDate", DateUtil.getDay());
					BptPeopleWar War =(BptPeopleWar)warRrcord.toBean(BptPeopleWar.class);
					iWarService.updateWar(War);
				}
				else if("61".equals(warTypeCode)&&testdataset.getCount()==1){
					if("0".equals(isApprove)&&"1".equals(isSure)){
						r.set("warNo", NOService.getNO("CS",domicileCode));
						r.set("warStateCode", "2");
						insertStateChange(baseinfoPeople,"1","2","61");
					}else if("0".equals(isApprove)&&"0".equals(isSure)){
						r.set("warNo", NOService.getNO("CS",domicileCode));
						r.set("warStateCode", "3");
						insertStateChange(baseinfoPeople,"1","3","61");
					}else{
						r.set("warStateCode", "6");
						insertStateChange(baseinfoPeople,"1","6","61");
					}
					Record testRrcord =testdataset.getRecord(0);
					testRrcord.set("approvalDate", DateUtil.getDay());
					BptPeopleTested Tested =(BptPeopleTested)testRrcord.toBean(BptPeopleTested.class);
					bptPeopleTestedService.updatePeopleTeseted(Tested);
				}
				
				baseinfoPeople =(BaseinfoPeople)r.toBean(BaseinfoPeople.class);
				service.updateBaseinfoPeople(baseinfoPeople);
			}
			
		}
	}
	/**
	 * 添加状态变更表数据
	 * @param baseinfoPeople
	 * @param prestate
	 * @param endstate
	 * @param serviceType
	 */
	public void insertStateChange(BaseinfoPeople baseinfoPeople ,String prestate,String endstate,String serviceType){
		BptStateChange bptStateChange = new BptStateChange();
		bptStateChange.setStateChangeId(IdHelp.getUUID30());
		bptStateChange.setPeopleId(baseinfoPeople.getPeopleId());
		/*String domiclile = baseinfoPeople.getDomicileCode();
		String outDomiclieCode = domiclile.substring(0, 6) + "000000";
		String outDomiclieCodeName = BptApplyEmigrationCommand
				.queryDomicileCodeName(outDomiclieCode);*/

		bptStateChange.setIdCard(baseinfoPeople.getIdCard());
		bptStateChange.setName(baseinfoPeople.getName());
		/*bptStateChange.setOutDomicileCode(outDomiclieCode);
		bptStateChange.setOutDomicileCodeName(outDomiclieCodeName);*/
		bptStateChange.setRegId(BspUtil.getEmpOrganId());
		bptStateChange.setRegTime(DateUtil.getTime());
		bptStateChange.setModId(BspUtil.getEmpOrganId());
		bptStateChange.setModTime(DateUtil.getTime());
		bptStateChange.setChangeStateDate(DateUtil.getDay());
		bptStateChange.setChangeStatePre(prestate);
		bptStateChange.setChangeStateSuf(endstate);
		bptStateChange.setObjectType(serviceType);
		stateChangeService.insert(bptStateChange);
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
