package com.inspur.cams.bpt.manage.cmd;

import java.util.HashMap;
import java.util.Map;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.next.web.cmd.CommandContext;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;
import org.loushang.workflow.api.WfTaskRequestWrapper;


import com.inspur.cams.bpt.base.data.BptPeopleDemobilized;
import com.inspur.cams.bpt.base.data.Demobilizedflow;
import com.inspur.cams.bpt.base.data.WfProcessBusiness;
import com.inspur.cams.bpt.base.domain.IBptApplyDemobilizedDomain;
import com.inspur.cams.bpt.base.domain.IBptApplyEmigrationDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDemobilizedDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDemobilizedIllnessDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDomain;
import com.inspur.cams.bpt.base.domain.IBptProvinceMigrateDomain;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.diccity.data.DicCity;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.IdHelp;

public class BptApplyDemobilizedCommand  extends BaseAjaxCommand{
	IBptProvinceMigrateDomain bptProvinceMigratService = ScaComponentFactory.getService(IBptProvinceMigrateDomain.class,
	"BptProvinceMigrateDomain/BptProvinceMigrateDomain");
	
	IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,"bptGroupDomain/bptGroupDomain");
	/**
	 * 获得在乡复员审批服务接口
	 */
	IBptApplyDemobilizedDomain bptApplyDemobilizedService = ScaComponentFactory.getService(IBptApplyDemobilizedDomain.class,
	"bptApplyDemobilizedDomain/bptApplyDemobilizedDomain");
	
	
	/**
	 * 工作流信息服务接口
	 */
	IWfProcessBusinessDomain wfProcessBusinessService = ScaComponentFactory.getService(IWfProcessBusinessDomain.class,
	"wfProcessBusinessDomain/wfProcessBusinessDomain");
	
	/**  
	 * 在乡复员军人服务接口
	 */
	IBptPeopleDemobilizedDomain peopleDemobilizedService = ScaComponentFactory.getService(IBptPeopleDemobilizedDomain.class,
	"bptPeopleDemobilizedDomain/bptPeopleDemobilizedDomain");
	
	/**
	 * 获得优抚人员服务接口
	 */
	IBptPeopleDomain bptPeopleService = ScaComponentFactory.getService(IBptPeopleDomain.class,
	"bptPeopleDomain/bptPeopleDomain");
	
	/**
	 * 在乡复员人员信息服务接口
	 */
	IBptApplyDemobilizedDomain demobilizedService = ScaComponentFactory.getService(IBptApplyDemobilizedDomain.class,
	"bptApplyDemobilizedDomain/bptApplyDemobilizedDomain");
	/**  
	 * 带病回乡军人服务接口
	 */
	IBptPeopleDemobilizedIllnessDomain demobilizedIllnessDomainService = ScaComponentFactory.getService(IBptPeopleDemobilizedIllnessDomain.class,
	"demobilizedIllnessDomain/demobilizedIllnessDomain");
	
	IBptApplyEmigrationDomain bptApplyEmigrationService = ScaComponentFactory.getService(IBptApplyEmigrationDomain.class,
	"BptApplyEmigrationDomain/BptApplyEmigrationDomain");
	/**  
	 * 删除带病回乡
	 */
	@Trans
	public void deleteDemobilizedIll(){
		Record[] records = (Record[]) getParameter("record");
		for (Record record : records) {
			String applyId =(String)record.get("APPLY_ID");
			String peopleId =(String)record.get("PEOPLE_ID");
			ParameterSet pst = new ParameterSet();
			pst.setParameter("applyId", applyId);
			pst.setParameter("peopleId", peopleId);
			bptApplyDemobilizedService.deleteDemobilizedIll(pst);
		}
		
	}
	/**  
	 * 删除在乡复员
	 */
	@Trans
	public void deleteDemobilized(){
		Record[] records = (Record[]) getParameter("record");
		for (Record record : records) {
			String applyId =(String)record.get("APPLY_ID");
			String peopleId =(String)record.get("PEOPLE_ID");
			ParameterSet pst = new ParameterSet();
			pst.setParameter("applyId", applyId);
			pst.setParameter("peopleId", peopleId);
			bptApplyDemobilizedService.deleteDemobilized(pst);
		}
		
	}
	/**
	 * 获取伤残审批信息判定是否提交
	 * @return
	 */
	public void queryApplyInfo() {
		ParameterSet pset = getParameterSet();
		DataSet ds =bptApplyDemobilizedService.query(pset);
		if(ds.getCount()>0){
			String trialName = (String)ds.getRecord(0).get("trialName");
			String townReport = (String)ds.getRecord(0).get("townReport");
			String townFlag = (String)ds.getRecord(0).get("townFlag");
			this.setReturn("trialName", trialName);
			this.setReturn("townReport", townReport);
			this.setReturn("townFlag", townFlag);
		}
	}
	/**
	 * 添加补证换证信息
	 */
	@Trans
	public void addExchaCertiDemo(){
		String applyId = IdHelp.getUUID30();
		Record record = (Record) getParameter("record");
		Demobilizedflow dateBean = (Demobilizedflow)record.toBean(Demobilizedflow.class);
		dateBean.setApplyId(applyId);
		dateBean.setExchacertiCommitFlag("0");
		dateBean.setServiceYype("44");
		demobilizedService.insert(dateBean);
	}
	/**
	 * 添加补证换证信息
	 */
	@Trans
	public void updateExchaCertiDemo(){

		Record record = (Record) getParameter("record");
		Demobilizedflow dateBean = (Demobilizedflow)record.toBean(Demobilizedflow.class);
		demobilizedService.updateExchaCertiDemo(dateBean);
	}
	/**
	 * 根据身份证号查询人员信息和在乡复员信息
	 */
	@SuppressWarnings("unchecked")
	public void queryByIdCard(){
		ParameterSet pset = getParameterSet();
		DataSet peopleDataSet = service.queryPeople(pset);
		Record peopleRecord = peopleDataSet.getRecord(0);
		if(peopleRecord.get("peopleId") != null){
			String peopleId = (String)peopleRecord.get("peopleId");
			setReturn("peopleId",peopleId);
			String familyId = (String)peopleRecord.get("familyId");
			setReturn("familyId",familyId);
			String name = (String)peopleRecord.get("name");
			String sex = (String)peopleRecord.get("sex");
			String nation =(String) peopleRecord.get("nation");
			String birthday =(String) peopleRecord.get("birthday");
			String apanageCode =(String) peopleRecord.get("apanageCode");
			
			setReturn("name",name);
			setReturn("sex",sex);
			setReturn("nation",nation);
			setReturn("birthday",birthday);
			
			if( peopleRecord.get("address") != null){
				String address =(String) peopleRecord.get("address");
				setReturn("address",address);
			}
			
			if(peopleRecord.get("demobilizedNo") != null){
				String demobilizedNo = (String)peopleRecord.get("demobilizedNo");
				setReturn("demobilizedNo",demobilizedNo);
			}
			
//			pset.clear();
//			pset.setParameter("PEOPLE_ID", peopleId);
//			DataSet bptPeopleDataSet = bptPeopleService.query(pset);
//			String disabilityTypeCode = bptPeopleDataSet.getRecord(0).get("disabilityTypeCode");
//			setReturn("disabilityTypeCode", disabilityTypeCode);
			
			//通过apanageCode获取domicileName
			EntityDao<DicCity> dao = (EntityDao<DicCity>)DaoFactory.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
			pset.clear();
			pset.setParameter("ID", apanageCode);
			DataSet apanageCodeDataSet = dao.query(pset);
			Record apanageCodeRecord = apanageCodeDataSet.getRecord(0);
			String apanageName = (String)apanageCodeRecord.get("name");
			setReturn("apanageName",apanageName);
			
			pset.clear();
			pset.setParameter("PEOPLE_ID", peopleId);
			DataSet demobilizedDataSet = peopleDemobilizedService.query(pset);
			Record demobilizedRecord = demobilizedDataSet.getRecord(0);
			
			if(demobilizedRecord.get("conscriptDate") != null){
				String conscriptDate = (String)demobilizedRecord.get("conscriptDate");
				setReturn("conscriptDate",conscriptDate);
			}
			if(	demobilizedRecord.get("belongDate") !=null){
				String belongDate= (String)demobilizedRecord.get("belongDate");
					setReturn("belongDate",belongDate);
				}
			if(	demobilizedRecord.get("position") !=null){
				String position= (String)demobilizedRecord.get("position");
					setReturn("position",position);
					System.out.println(position);
				}
			//复员时间
			if(	demobilizedRecord.get("decruitmentDate") !=null){
			String decruitmentDate= (String)demobilizedRecord.get("decruitmentDate");
			setReturn("decruitmentDate",decruitmentDate);
				}
			//IS_KOREANWAR是否抗美援朝
			if(	demobilizedRecord.get("isKoeanwar") !=null){
			String isKoeanwar= (String)demobilizedRecord.get("isKoeanwar");
			setReturn("isKoeanwar",isKoeanwar);
			}
			}
		}
	@Trans
	public void  createAndSend() {
		
		Record record = (Record) getParameter("record");
		
		String peopleId = (String)record.get("PEOPLE_ID");
		String apply = (String)record.get("APPLY_ID");
		ParameterSet pset = getParameterSet();
		pset.clear();
		pset.setParameter("PEOPLE_ID@=", peopleId);
		DataSet ds = service.queryDemobilizedInfo(pset);
		BptPeopleDemobilized dataBean= (BptPeopleDemobilized)ds.getRecord(0).toBean(BptPeopleDemobilized.class);
		//修改在乡复员人员信息
		service.updateBptPeopleDemobilized(dataBean);
		
		//获得在乡复员审批信息【在在乡复员审批表里面添加一条记录】
		Demobilizedflow BptPeopleDemobilizedBean = new Demobilizedflow();
		BptPeopleDemobilizedBean.setApplyId(apply);
		BptPeopleDemobilizedBean.setExchacertiCommitFlag("1");
		bptApplyDemobilizedService.update(BptPeopleDemobilizedBean);

        // 调用创建并发送流程接口
		
		CommandContext.setContextParameter("procDefUniqueId", "8a898b4a31fadc080131fae38a100009");
		CommandContext.setContextParameter("startActDefUniqueId", "8a898b4a31fadc080131faf062750017");
		Map context = new HashMap();
		String town_OrganId = BspUtil.getCorpStruId();
		String currentOrganName =  BspUtil.getCorpOrgan().getOrganName();

		context.put("Towm_OrganId", town_OrganId);
		Map map=WfTaskRequestWrapper.getInstance().createAndSend(apply, currentOrganName+"的在乡复员人员换证、补证申请", context);
		//Map map=WfTaskRequestWrapper.getInstance().createAndSendByProcDefId( "E4D0F11846114A14108168B1587A3D6E","act1", "业务主键id1", "new区县的配置伤残器械申请");
		String processId = (String)map.get("processId");

		//增加工作流信息表
		WfProcessBusiness wfProcessBusiness = new WfProcessBusiness();
		wfProcessBusiness.setProcessId(processId);
		wfProcessBusiness.setBusinessId(apply);
		wfProcessBusiness.setConnectId(peopleId);
		wfProcessBusiness.setBusinessType("44");
		wfProcessBusinessService.insert(wfProcessBusiness);

		
	}
	
/**
 * 根据身份证号查询人员信息和在乡复员信息
 */
@SuppressWarnings("unchecked")
public void queryIllByIdCard(){
	ParameterSet pset = getParameterSet();
	DataSet peopleDataSet = service.queryPeople(pset);
	Record peopleRecord = peopleDataSet.getRecord(0);


	if(peopleRecord.get("peopleId") != null){
		String peopleId = (String)peopleRecord.get("peopleId");
		setReturn("peopleId",peopleId);
		String familyId = (String)peopleRecord.get("familyId");
		setReturn("familyId",familyId);
		String name = (String)peopleRecord.get("name");
		String sex = (String)peopleRecord.get("sex");
		String nation =(String) peopleRecord.get("nation");
		String birthday =(String) peopleRecord.get("birthday");
		String apanageCode =(String) peopleRecord.get("apanageCode");
		ParameterSet pset1 =new ParameterSet();
		pset1.setParameter("PEOPLE_ID@=", peopleId);
		DataSet peopleDataset = service.queryPeople(pset1);
		Record rd3 = peopleDataset.getRecord(0);
		DataSet bptPeoleDataSet = service.queryBptPeople(pset1);
		Record rd2 = bptPeoleDataSet.getRecord(0);
		setReturn("name",name);
		setReturn("sex",sex);
		setReturn("nation",nation);
		setReturn("birthday",birthday);
		setReturn("disabilityTypeCode",rd2.get("disabilityTypeCode"));
		setReturn("dependantTypeCode",rd2.get("dependantTypeCode"));
		setReturn("redaTypeCode",rd2.get("redaTypeCode"));
		setReturn("warTypeCode",rd2.get("warTypeCode"));
		setReturn("bank",rd2.get("bank"));
		setReturn("workAbilityCode",rd2.get("workAbilityCode"));
		setReturn("viabilityCode",rd2.get("viabilityCode"));
		setReturn("oldLonelyFlag",rd2.get("oldLonelyFlag"));
		setReturn("orphanFlag",rd2.get("orphanFlag"));
		setReturn("insanityFlag",rd2.get("insanityFlag"));
		setReturn("accountCode",rd2.get("accountCode"));
		setReturn("supportPattern",rd2.get("supportPattern"));
		setReturn("accountName",rd2.get("accountName"));
		setReturn("physiclalStatus",rd2.get("physiclalStatus"));
		setReturn("demobilizedStateCode",rd3.get("demobilizedStateCode"));
		
		if( peopleRecord.get("address") != null){
			String address =(String) peopleRecord.get("address");
			setReturn("address",address);
		}
		
		if(peopleRecord.get("demobilizedNo") != null){
			String demobilizedNo = (String)peopleRecord.get("demobilizedNo");
			setReturn("demobilizedNo",demobilizedNo);
		}
		//通过apanageCode获取domicileName
		EntityDao<DicCity> dao = (EntityDao<DicCity>)DaoFactory.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		pset.clear();
		pset.setParameter("ID", apanageCode);
		DataSet apanageCodeDataSet = dao.query(pset);
		Record apanageCodeRecord = apanageCodeDataSet.getRecord(0);
		String apanageName = (String)apanageCodeRecord.get("name");
		setReturn("apanageName",apanageName);
		
		pset.clear();
		pset.setParameter("PEOPLE_ID", peopleId);
		DataSet demobilizedDataSet = demobilizedIllnessDomainService.query(pset);
		Record demobilizedRecord = demobilizedDataSet.getRecord(0);
		
		if(demobilizedRecord.get("conscriptDate") != null){
			String conscriptDate = (String)demobilizedRecord.get("conscriptDate");
			setReturn("conscriptDate",conscriptDate);
		}
		if(demobilizedRecord.get("illessInfo") != null){
			String illessInfo = (String)demobilizedRecord.get("illessInfo");
			setReturn("illessInfo",illessInfo);
		}
		if(	demobilizedRecord.get("isWar") !=null){
			String isWar= (String)demobilizedRecord.get("isWar");
				setReturn("isWar",isWar);
			}
		if(	demobilizedRecord.get("familyEconomics") !=null){
			String familyEconomics= (String)demobilizedRecord.get("familyEconomics");
				setReturn("familyEconomics",familyEconomics);
			
			}
		//复员时间
		if(	demobilizedRecord.get("decruitmentDate") !=null){
		String decruitmentDate= (String)demobilizedRecord.get("decruitmentDate");
		setReturn("decruitmentDate",decruitmentDate);
			}
		if(	demobilizedRecord.get("approvalDate") !=null){
		String approvalDate= (String)demobilizedRecord.get("approvalDate");
		setReturn("approvalDate",approvalDate);
		}
		if(	demobilizedRecord.get("isInnuclear") !=null){
			String isInnuclear= (String)demobilizedRecord.get("isInnuclear");
			setReturn("isInnuclear",isInnuclear);
			}
		if(	demobilizedRecord.get("asdpNo") !=null){
			String asdpNo= (String)demobilizedRecord.get("asdpNo");
			setReturn("asdpNo",asdpNo);
			}
		}
	}
/**
 * 根据身份证号查询人员信息和带病回乡信息
 */
@SuppressWarnings("unchecked")
public void updateIllnessByIdCard(){
	ParameterSet pset = getParameterSet();
	String applyId =  (String) pset.getParameter("APPLY_ID");
	pset.remove("APPLY_ID");
	DataSet peopleDataSet = service.queryPeople(pset);
	Record peopleRecord = peopleDataSet.getRecord(0);


	if(peopleRecord.get("peopleId") != null){
		String peopleId = (String)peopleRecord.get("peopleId");
		setReturn("peopleId",peopleId);
		String familyId = (String)peopleRecord.get("familyId");
		setReturn("familyId",familyId);
		String name = (String)peopleRecord.get("name");
		String sex = (String)peopleRecord.get("sex");
		String nation =(String) peopleRecord.get("nation");
		String birthday =(String) peopleRecord.get("birthday");
		String apanageCode =(String) peopleRecord.get("apanageCode");
		ParameterSet pset1 =new ParameterSet();
		pset1.setParameter("PEOPLE_ID@=", peopleId);
		DataSet peopleDataset = service.queryPeople(pset1);
		Record rd3 = peopleDataset.getRecord(0);
		DataSet bptPeoleDataSet = service.queryBptPeople(pset1);
		Record rd2 = bptPeoleDataSet.getRecord(0);
		setReturn("name",name);
		setReturn("sex",sex);
		setReturn("nation",nation);
		setReturn("birthday",birthday);
		setReturn("disabilityTypeCode",rd2.get("disabilityTypeCode"));
		setReturn("dependantTypeCode",rd2.get("dependantTypeCode"));
		setReturn("redaTypeCode",rd2.get("redaTypeCode"));
		setReturn("warTypeCode",rd2.get("warTypeCode"));
		setReturn("bank",rd2.get("bank"));
		setReturn("workAbilityCode",rd2.get("workAbilityCode"));
		setReturn("viabilityCode",rd2.get("viabilityCode"));
		setReturn("oldLonelyFlag",rd2.get("oldLonelyFlag"));
		setReturn("orphanFlag",rd2.get("orphanFlag"));
		setReturn("insanityFlag",rd2.get("insanityFlag"));
		setReturn("accountCode",rd2.get("accountCode"));
		setReturn("supportPattern",rd2.get("supportPattern"));
		setReturn("accountName",rd2.get("accountName"));
		setReturn("physiclalStatus",rd2.get("physiclalStatus"));
		setReturn("demobilizedStateCode",rd3.get("demobilizedStateCode"));
		
		if( peopleRecord.get("address") != null){
			String address =(String) peopleRecord.get("address");
			setReturn("address",address);
		}
		
		if(peopleRecord.get("demobilizedNo") != null){
			String demobilizedNo = (String)peopleRecord.get("demobilizedNo");
			setReturn("demobilizedNo",demobilizedNo);
		}
		//通过apanageCode获取domicileName
		EntityDao<DicCity> dao = (EntityDao<DicCity>)DaoFactory.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		pset.clear();
		pset.setParameter("ID", apanageCode);
		DataSet apanageCodeDataSet = dao.query(pset);
		Record apanageCodeRecord = apanageCodeDataSet.getRecord(0);
		String apanageName = (String)apanageCodeRecord.get("name");
		setReturn("apanageName",apanageName);
		
		pset.clear();
		pset.setParameter("PEOPLE_ID", peopleId);
		DataSet demobilizedDataSet = demobilizedIllnessDomainService.query(pset);
		Record demobilizedRecord = demobilizedDataSet.getRecord(0);
		
		if(demobilizedRecord.get("conscriptDate") != null){
			String conscriptDate = (String)demobilizedRecord.get("conscriptDate");
			setReturn("conscriptDate",conscriptDate);
		}
		if(demobilizedRecord.get("illessInfo") != null){
			String illessInfo = (String)demobilizedRecord.get("illessInfo");
			setReturn("illessInfo",illessInfo);
		}
		if(	demobilizedRecord.get("isWar") !=null){
			String isWar= (String)demobilizedRecord.get("isWar");
				setReturn("isWar",isWar);
			}
		if(	demobilizedRecord.get("familyEconomics") !=null){
			String familyEconomics= (String)demobilizedRecord.get("familyEconomics");
				setReturn("familyEconomics",familyEconomics);
			
			}
		//复员时间
		if(	demobilizedRecord.get("decruitmentDate") !=null){
		String decruitmentDate= (String)demobilizedRecord.get("decruitmentDate");
		setReturn("decruitmentDate",decruitmentDate);
			}
		if(	demobilizedRecord.get("approvalDate") !=null){
		String approvalDate= (String)demobilizedRecord.get("approvalDate");
		setReturn("approvalDate",approvalDate);
		}
		if(	demobilizedRecord.get("isInnuclear") !=null){
			String isInnuclear= (String)demobilizedRecord.get("isInnuclear");
			setReturn("isInnuclear",isInnuclear);
			}
		if(	demobilizedRecord.get("asdpNo") !=null){
			String asdpNo= (String)demobilizedRecord.get("asdpNo");
			setReturn("asdpNo",asdpNo);
			}
		//查询迁入地民政局名称和抚恤金发放至月份
		pset.clear();
		pset.setParameter("APPLY_ID", applyId);
		DataSet disEmigDataSet = bptApplyEmigrationService.query(pset);
		String ingoingAddress = disEmigDataSet.getRecord(0).get("ingoingAddress").toString();
		String allowanceMonth = disEmigDataSet.getRecord(0).get("allowanceMonth").toString();
		if(disEmigDataSet.getRecord(0).get("townCheckPhone")!=null){
			String townCheckPhone = disEmigDataSet.getRecord(0).get("townCheckPhone").toString();
			setReturn("townCheckPhone",townCheckPhone);
		}
		setReturn("ingoingAddress",ingoingAddress);
		setReturn("allowanceMonth",allowanceMonth);
		}
	}
/**
 * 根据身份证号查询人员信息和带病回乡信息
 */
@SuppressWarnings("unchecked")
public void updateIllprovinceByIdCard(){
	ParameterSet pset = getParameterSet();
	String applyId =  (String) pset.getParameter("APPLY_ID");
	pset.remove("APPLY_ID");
	DataSet peopleDataSet = service.queryPeople(pset);
	Record peopleRecord = peopleDataSet.getRecord(0);


	if(peopleRecord.get("peopleId") != null){
		String peopleId = (String)peopleRecord.get("peopleId");
		setReturn("peopleId",peopleId);
		String familyId = (String)peopleRecord.get("familyId");
		setReturn("familyId",familyId);
		String name = (String)peopleRecord.get("name");
		String sex = (String)peopleRecord.get("sex");
		String nation =(String) peopleRecord.get("nation");
		String birthday =(String) peopleRecord.get("birthday");
		String apanageCode =(String) peopleRecord.get("apanageCode");
		ParameterSet pset1 =new ParameterSet();
		pset1.setParameter("PEOPLE_ID@=", peopleId);
		DataSet peopleDataset = service.queryPeople(pset1);
		Record rd3 = peopleDataset.getRecord(0);
		DataSet bptPeoleDataSet = service.queryBptPeople(pset1);
		Record rd2 = bptPeoleDataSet.getRecord(0);
		setReturn("name",name);
		setReturn("sex",sex);
		setReturn("nation",nation);
		setReturn("birthday",birthday);
		setReturn("disabilityTypeCode",rd2.get("disabilityTypeCode"));
		setReturn("dependantTypeCode",rd2.get("dependantTypeCode"));
		setReturn("redaTypeCode",rd2.get("redaTypeCode"));
		setReturn("warTypeCode",rd2.get("warTypeCode"));
		setReturn("bank",rd2.get("bank"));
		setReturn("workAbilityCode",rd2.get("workAbilityCode"));
		setReturn("viabilityCode",rd2.get("viabilityCode"));
		setReturn("oldLonelyFlag",rd2.get("oldLonelyFlag"));
		setReturn("orphanFlag",rd2.get("orphanFlag"));
		setReturn("insanityFlag",rd2.get("insanityFlag"));
		setReturn("accountCode",rd2.get("accountCode"));
		setReturn("supportPattern",rd2.get("supportPattern"));
		setReturn("accountName",rd2.get("accountName"));
		setReturn("physiclalStatus",rd2.get("physiclalStatus"));
		setReturn("demobilizedStateCode",rd3.get("demobilizedStateCode"));
		
		if( peopleRecord.get("address") != null){
			String address =(String) peopleRecord.get("address");
			setReturn("address",address);
		}
		
		if(peopleRecord.get("demobilizedNo") != null){
			String demobilizedNo = (String)peopleRecord.get("demobilizedNo");
			setReturn("demobilizedNo",demobilizedNo);
		}
		//通过apanageCode获取domicileName
		EntityDao<DicCity> dao = (EntityDao<DicCity>)DaoFactory.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		pset.clear();
		pset.setParameter("ID", apanageCode);
		DataSet apanageCodeDataSet = dao.query(pset);
		Record apanageCodeRecord = apanageCodeDataSet.getRecord(0);
		String apanageName = (String)apanageCodeRecord.get("name");
		setReturn("apanageName",apanageName);
		
		pset.clear();
		pset.setParameter("PEOPLE_ID", peopleId);
		DataSet demobilizedDataSet = demobilizedIllnessDomainService.query(pset);
		Record demobilizedRecord = demobilizedDataSet.getRecord(0);
		
		if(demobilizedRecord.get("conscriptDate") != null){
			String conscriptDate = (String)demobilizedRecord.get("conscriptDate");
			setReturn("conscriptDate",conscriptDate);
		}
		if(demobilizedRecord.get("illessInfo") != null){
			String illessInfo = (String)demobilizedRecord.get("illessInfo");
			setReturn("illessInfo",illessInfo);
		}
		if(	demobilizedRecord.get("isWar") !=null){
			String isWar= (String)demobilizedRecord.get("isWar");
				setReturn("isWar",isWar);
			}
		if(	demobilizedRecord.get("familyEconomics") !=null){
			String familyEconomics= (String)demobilizedRecord.get("familyEconomics");
				setReturn("familyEconomics",familyEconomics);
			
			}
		//复员时间
		if(	demobilizedRecord.get("decruitmentDate") !=null){
		String decruitmentDate= (String)demobilizedRecord.get("decruitmentDate");
		setReturn("decruitmentDate",decruitmentDate);
			}
		if(	demobilizedRecord.get("approvalDate") !=null){
		String approvalDate= (String)demobilizedRecord.get("approvalDate");
		setReturn("approvalDate",approvalDate);
		}
		if(	demobilizedRecord.get("isInnuclear") !=null){
			String isInnuclear= (String)demobilizedRecord.get("isInnuclear");
			setReturn("isInnuclear",isInnuclear);
			}
		if(	demobilizedRecord.get("asdpNo") !=null){
			String asdpNo= (String)demobilizedRecord.get("asdpNo");
			setReturn("asdpNo",asdpNo);
			}
		//查询迁入地民政局名称和抚恤金发放至月份
		pset.clear();
		pset.setParameter("APPLY_ID@=", applyId);
		DataSet disEmigDataSet = bptProvinceMigratService.query(pset);
		String ingoingCode = disEmigDataSet.getRecord(0).get("ingoingCode").toString();
		setReturn("ingoingCode",ingoingCode);

		pset.clear();
		pset.setParameter("ID", ingoingCode);
		String ingoingAddress = dao.query(pset).getRecord(0).get("name").toString();
		String allowanceMonth = disEmigDataSet.getRecord(0).get("allowanceMonth").toString();
		if(disEmigDataSet.getRecord(0).get("outTownCheckPhone")!=null){
			String outTownCheckPhone = disEmigDataSet.getRecord(0).get("outTownCheckPhone").toString();
			setReturn("outTownCheckPhone",outTownCheckPhone);
		}
		setReturn("ingoingAddress",ingoingAddress);
		setReturn("allowanceMonth",allowanceMonth);
		}
	}
	}


