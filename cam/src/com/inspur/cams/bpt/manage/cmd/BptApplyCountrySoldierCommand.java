package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.dao.IBptApplyMartyrOffspringDao;
import com.inspur.cams.bpt.base.dao.jdbc.BptCountRetiredSoldierDao;
import com.inspur.cams.bpt.base.data.BptApplyMartyrOffspring;
import com.inspur.cams.bpt.base.data.BptCountRetiredSoldier;
import com.inspur.cams.bpt.base.data.BptPeople;
import com.inspur.cams.bpt.base.data.BptStateChange;
import com.inspur.cams.bpt.base.domain.IBptPeopleDomain;
import com.inspur.cams.bpt.base.domain.IBptStateChangeDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:BptApplyCountrySoldierQueryCommand
 * @description: 60周岁以上农村籍退役士兵 操作command
 * @author:
 * @since:
 * @version:
*/
public class BptApplyCountrySoldierCommand extends BaseAjaxCommand{
	
	IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,
	"bptGroupDomain/bptGroupDomain");
	// 状态变更接口
	private IBptStateChangeDomain stateChangeService = ScaComponentFactory
			.getService(IBptStateChangeDomain.class,
					"bptStateChangeDomain/bptStateChangeDomain");
	/**
	 * 获得优抚人员服务接口
	 */
	IBptPeopleDomain bptPeopleService = ScaComponentFactory.getService(IBptPeopleDomain.class,
	"bptPeopleDomain/bptPeopleDomain");	
	
	/**
	 * 新增年满60周岁农村籍退役士兵申请
	 */
	@Trans
	public void insert() {
		IBptApplyMartyrOffspringDao applyDao = (IBptApplyMartyrOffspringDao)DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptApplyMartyrOffspringDao");
		BptCountRetiredSoldierDao dao = (BptCountRetiredSoldierDao) DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptCountRetiredSoldierDao");
		Record baseinfopeopleRecord = (Record) getParameter("BaseinfoPeopleRecord");
		Record record = (Record)getParameter("record");
		String flag = (String) getParameter("flag");
		BaseinfoPeople baseinfopeople = getBaseinfoPeople(baseinfopeopleRecord);
		BaseinfoFamily baseinfofamily = BptGetBusinessBean.getBaseinfoFamily(baseinfopeopleRecord);
		BptPeople bptPeople = getBptPeople(record);
		BptCountRetiredSoldier bptCountRetiredSoldier = getBptCountRetiredSoldier(record);
		
		String peoplePhotoTemp=baseinfopeople.getPhotoTemp();
		String nowTime = DateUtil.getTime();
		String areaCode=baseinfopeople.getRegOrgArea();
		String employeeName=baseinfopeople.getRegPeople();
		BptGetBusinessBean.dealPhotoC(baseinfopeople, nowTime, areaCode, employeeName,peoplePhotoTemp);//处理照片
		
		if(flag.equals("1")){
			String peopleIdRe = IdHelp.getUUID30();
	     	String familyIdRe = IdHelp.getUUID30();
	     	baseinfopeople.setPeopleId(peopleIdRe);
	     	baseinfopeople.setFamilyId(familyIdRe);
	     	baseinfofamily.setFamilyId(familyIdRe);
	     	bptPeople.setPeopleId(peopleIdRe);
	     	bptCountRetiredSoldier.setPeopleId(peopleIdRe);
		   service.insertBaseinfo(baseinfopeople, baseinfofamily);
		   dao.insert(bptCountRetiredSoldier);
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
			dao.insert(bptCountRetiredSoldier);
		}
		  setReturn("peopleId", baseinfopeople.getPeopleId());
	      setReturn("familyId", baseinfopeople.getFamilyId());
	      
	      String applyId = IdHelp.getUUID32();
	      
	      BptApplyMartyrOffspring applyCountSoldierBean = new BptApplyMartyrOffspring();
	      applyCountSoldierBean.setPeopleId(baseinfopeople.getPeopleId());
	      applyCountSoldierBean.setApplyId(applyId);
	      applyCountSoldierBean.setApplyDate(DateUtil.getDay());
	      applyCountSoldierBean.setApproveOrganId(BspUtil.getOrganCode());
		  applyCountSoldierBean.setCommitFlag("0");
		  applyCountSoldierBean.setServiceType("81");
		  applyCountSoldierBean.setRegId(BspUtil.getEmpOrganId());
		  applyCountSoldierBean.setRegTime(DateUtil.getTime());
		  applyDao.insert(applyCountSoldierBean);
		  setReturn("applyId",applyId);
	}
	
	/**
	 *	获取人员基本信息
	 */
	private BaseinfoPeople getBaseinfoPeople(Record baseinfopeopleRecord) {
		BaseinfoPeople bean = (BaseinfoPeople) baseinfopeopleRecord.toBean(BaseinfoPeople.class);
		bean.setRetiredFlag("1");
		bean.setRetiredStateCode("1");
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
	private BptPeople getBptPeople(Record record){
		BptPeople bptPeople = new BptPeople();
		bptPeople.setRetiredTypeCode("81");
		String peopleId = (String)record.get("peopleId");
		ParameterSet param = new ParameterSet();
		param.setParameter("PEOPLE_ID",peopleId);
		DataSet ds =service.queryBptPeople(param);
		if(ds.getCount()!=0){
			bptPeople = (BptPeople)ds.getRecord(0).toBean(BptPeople.class);
			bptPeople.setBank((String)record.get("bank"));
			bptPeople.setAccountCode((String)record.get("accountCode"));
			bptPeople.setAccountName((String)record.get("accountName"));
			bptPeople.setOldLonelyFlag((String)record.get("oldLonelyFlag"));
			bptPeople.setWorkAbilityCode((String)record.get("workAbilityCode"));
		}else{
			bptPeople = (BptPeople)record.toBean(BptPeople.class);
			bptPeople.setPeopleId((String)record.get("peopleId"));
			bptPeople.setInsanityFlag("0");
			bptPeople.setDisabilityTypeCode("00");
			bptPeople.setDependantTypeCode("00");
			bptPeople.setRedaTypeCode("00");
		    bptPeople.setDemobilizedTyepCode("00");
		    bptPeople.setWarTypeCode("00");
		    bptPeople.setMartyrOffspringCode("00");
		}
		return bptPeople;
	}
	
	/**
	 *  获取退役士兵信息
	 */
	private BptCountRetiredSoldier getBptCountRetiredSoldier(Record rd ){
		BptCountRetiredSoldier bean = (BptCountRetiredSoldier) rd.toBean(BptCountRetiredSoldier.class);
		bean.setPeopleId(rd.get("peopleId").toString());
        bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
        bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}
	
	/**
	 * 更新实体
	 */
	@Trans
	public void update(){
		BptApplyMartyrOffspring bean = (BptApplyMartyrOffspring)((Record)getParameter("record")).toBean(BptApplyMartyrOffspring.class);
		IBptApplyMartyrOffspringDao dao = (IBptApplyMartyrOffspringDao)DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptApplyMartyrOffspringDao");
		dao.update(bean);
	}
	
	/**
	 *  判断县级审核内容是否提交
	 */
	@Trans
	public void getSaveFlag(){
		String applyId = (String)getParameter("applyId");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("APPLY_ID", applyId);
		String saveFlag = null;
		IBptApplyMartyrOffspringDao dao = (IBptApplyMartyrOffspringDao)DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptApplyMartyrOffspringDao");
		DataSet ds = dao.query(pset);
		if(ds.getCount()>0){
			String checkApproveDate = (String)ds.getRecord(0).get("auditDate");
			if(checkApproveDate!=null&&!"".equals(checkApproveDate)){
				saveFlag = "1";
			}else{
				saveFlag = "0";
			}
		}else{
			saveFlag = "0";
		}
		this.setReturn("saveFlag", saveFlag);
	}
	
	/**
	 * 提交申请
	 */
	@Trans
	public void applySubmit(){
		String applyId = (String)getParameter("applyId");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("APPLY_ID", applyId);
		IBptApplyMartyrOffspringDao dao = (IBptApplyMartyrOffspringDao)DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptApplyMartyrOffspringDao");
		DataSet ds = dao.query(pset);
		BptApplyMartyrOffspring bean = (BptApplyMartyrOffspring)((Record)ds.getRecord(0)).toBean(BptApplyMartyrOffspring.class);
		bean.setApplyDate(DateUtil.getDay());
		bean.setApproveOrganId(BspUtil.getOrganCode());
		bean.setCommitFlag("1");
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		dao.update(bean);
		
		String peopleId = bean.getPeopleId();
		ParameterSet pset1 = new ParameterSet();
		pset1.setParameter("PEOPLE_ID",peopleId);
		//更新类别信息
		BptCountRetiredSoldierDao countRetiredSoldierDao = (BptCountRetiredSoldierDao) DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptCountRetiredSoldierDao");
		BptCountRetiredSoldier cCountRetiredSoldierBean = (BptCountRetiredSoldier)countRetiredSoldierDao.query(pset1).getRecord(0).toBean(BptCountRetiredSoldier.class);
		cCountRetiredSoldierBean.setApprovalDate(DateUtil.getDay());
		cCountRetiredSoldierBean.setModId(BspUtil.getEmpOrganId());
		cCountRetiredSoldierBean.setModTime(DateUtil.getTime());
		countRetiredSoldierDao.update(cCountRetiredSoldierBean);
		//更新优抚对象状态
		String agreeFlag = bean.getAgreeFlag();
		IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class, "bptGroupDomain/bptGroupDomain");
		BaseinfoPeople peopleBean = (BaseinfoPeople)service.queryPeople(pset1).getRecord(0).toBean(BaseinfoPeople.class);
		if("0".equals(agreeFlag)){
			peopleBean.setRetiredStateCode("2");
			insertStateChange(peopleBean,"1","2","81");
		}else if("1".equals(agreeFlag)){
			peopleBean.setRetiredStateCode("6");
			insertStateChange(peopleBean,"1","6","81");
		}
		peopleBean.setModId(BspUtil.getEmpOrganId());
		peopleBean.setModTime(DateUtil.getTime());
		service.updateBaseinfoPeople(peopleBean);
	}
	
	/**
	 * 删除60周岁以上农村籍退役士兵申请
	 */
	@Trans
	public void deleteCountrySoldier(){
		IBptApplyMartyrOffspringDao dao = (IBptApplyMartyrOffspringDao)DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptApplyMartyrOffspringDao");
		Record[] records = (Record[])getParameter("records");
		for(Record rd:records){
			String applyId = (String)rd.get("APPLY_ID");
			String peopleId = (String)rd.get("PEOPLE_ID");
			ParameterSet pset = new ParameterSet();
			pset.setParameter("applyId", applyId);
			pset.setParameter("peopleId", peopleId);
			dao.deleteCountrySoldier(pset);
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
}
