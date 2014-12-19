package com.inspur.cams.bpt.manage.cmd;

import java.util.*;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.next.web.cmd.CommandContext;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;
import org.loushang.workflow.api.WfTaskRequestWrapper;

import com.inspur.cams.bpt.base.dao.jdbc.DemobilizedflowDao;
import com.inspur.cams.bpt.base.data.BptApplyDisability;
import com.inspur.cams.bpt.base.data.BptApplyHistory;
import com.inspur.cams.bpt.base.data.BptPeopleDemobilized;
import com.inspur.cams.bpt.base.data.BptPeopleDemobilizedIllness;
import com.inspur.cams.bpt.base.data.BptStateChange;
import com.inspur.cams.bpt.base.data.Demobilizedflow;
import com.inspur.cams.bpt.base.domain.IBptApplyHistoryDomain;
import com.inspur.cams.bpt.base.domain.IBptComfortNoDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDemobilizedDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDemobilizedIllnessDomain;
import com.inspur.cams.bpt.base.domain.IBptStateChangeDomain;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;
import com.inspur.cams.bpt.base.domain.support.BptComfortNoDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;


/**
 * @title:DemobilizedflowCommand
 * @description:
 * @author:
 * @since:2011-07-29
 * @version:1.0
*/
public class DemobilizedflowCommand extends BaseAjaxCommand{
	/**
	 * 工作流信息服务接口
	 */
	IWfProcessBusinessDomain wfProcessBusinessService = ScaComponentFactory.getService(IWfProcessBusinessDomain.class,
	"wfProcessBusinessDomain/wfProcessBusinessDomain");
	
	IBptComfortNoDomain NOService = ScaComponentFactory.getService(BptComfortNoDomain.class,"bptComfortNoDomain/bptComfortNoDomain");
	
	IBptGroupDomain service = ScaComponentFactory.getService(
			IBptGroupDomain.class, "bptGroupDomain/bptGroupDomain");
	
	IBptPeopleDemobilizedDomain demobilizedService = ScaComponentFactory.getService(
			IBptPeopleDemobilizedDomain.class, "bptPeopleDemobilizedDomain/bptPeopleDemobilizedDomain");
	
	IBptPeopleDemobilizedIllnessDomain demobilizedIllnessService = ScaComponentFactory.getService(
			IBptPeopleDemobilizedIllnessDomain.class, "demobilizedIllnessDomain/demobilizedIllnessDomain");
	
	private DemobilizedflowDao dao = (DemobilizedflowDao) DaoFactory
			.getDao("com.inspur.cams.bpt.base.dao.jdbc.DemobilizedflowDao");
	/**
	 * 审批记录历史服务接口
	 */
	IBptApplyHistoryDomain bptApplyHistoryService = ScaComponentFactory.getService(IBptApplyHistoryDomain.class,
	"BptApplyHistoryDomain/BptApplyHistoryDomain");
	
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		Demobilizedflow dataBean=(Demobilizedflow)record.toBean(Demobilizedflow.class);
		dao.insert(dataBean);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		Demobilizedflow dataBean=(Demobilizedflow)record.toBean(Demobilizedflow.class);
		dao.update(dataBean);
	}
	@Trans
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	/*public void save1() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<Demobilizedflow> list = new ArrayList<Demobilizedflow>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			Demobilizedflow dataBean = (Demobilizedflow) records[i].toBean(Demobilizedflow.class);
			list.add(dataBean);
		}

		dao.save(list);
	}*/
	@Trans
	public void save() {
		Record records = (Record) getParameter("records");
		List<Demobilizedflow> list = new ArrayList<Demobilizedflow>();
		Demobilizedflow dataBean = (Demobilizedflow) records.toBean(Demobilizedflow.class);
		dao.update(dataBean);
	}
	/**
	 * 回退流程
	 */
	@Trans
	public void back(){
		save();
		insertBptApplyHistory(); // 添加审批记录
		String assignmentId = (String)getParameter("assignmentId");
		CommandContext.setContextParameter("assignmentId", assignmentId);
		//调用工作流回退接口
		
		WfTaskRequestWrapper.getInstance().back();
		
		// 修改是否被退回标示为y（退回）
		ParameterSet pset = new ParameterSet();
		pset.setParameter("applyId", (String)getParameter("applyId"));
		pset.setParameter("ifback", "y");
		wfProcessBusinessService.updateIfback(pset);
	}
	
	/**
	 * 发送流程
	 */
	@Trans
	public void send(){
		save();
		String assignmentId = (String)getParameter("assignmentId");
		String condition = (String)getParameter("condition");
		Map<String,String> context = new HashMap<String,String>();
		String town_OrganId = BspUtil.getParentStrId();
	
		String City_Verify_OrganId = BspUtil.getCorpStruId();
		context.put("Condition",condition);
		context.put("City_OrganId", town_OrganId);
		context.put("City_Verify_OrganId", City_Verify_OrganId);		
		
		 
		CommandContext.setContextParameter("assignmentId", assignmentId);
		//调用工作流发送接口
		Map map = WfTaskRequestWrapper.getInstance().send(context);
		// 修改是否被退回标示为n（非退回）
		ParameterSet pset = new ParameterSet();
		pset.setParameter("applyId", (String)getParameter("applyId"));
		pset.setParameter("ifback", "n");
		wfProcessBusinessService.updateIfback(pset);
		
		
		//判段是否是县级提交 如果是修改流程发起时间为当前时间
		if("13".equals(BspUtil.getOrganType())){
			ParameterSet psettime = new ParameterSet();
			psettime.setParameter("applyId", (String) getParameter("applyId"));
			wfProcessBusinessService.updateProCreateTime(psettime);
		}
		
		insertBptApplyHistory(); // 添加审批记录
		if (map.containsKey("isEnd")&&"true".equals((String) map.get("isEnd"))) { // 流程完成后修改在乡复员或带病回乡信息
			if(condition.equals("0")){
				updateInfo("2");
			}else if(condition.equals("1")){//不予评定
				updateInfo("6");
			}
		}
	}
	/**
	 * 添加审批记录
	 * @param pset
	 */
	@Trans
	private void insertBptApplyHistory() {
		String currentField = (String)getParameter("currentField"); //当前域
		String applyId = (String)getParameter("applyId");
		String actDefName = (String)getParameter("actDefName");
		Record record = (Record) getParameter("records");
		Demobilizedflow dataBean = (Demobilizedflow) record.toBean(Demobilizedflow.class);
		// 插入审批记录历史表
		BptApplyHistory bptApplyHistory = new BptApplyHistory();
		bptApplyHistory.setHistoryId(IdHelp.getUUID30());
		bptApplyHistory.setActdefName(actDefName);
		bptApplyHistory.setCreateTime(DateUtil.getTime());
		bptApplyHistory.setApplyId(applyId);
		if("TownVerify".equals(currentField)) { // 县级
			ParameterSet param = new ParameterSet();
			param.setParameter("APPLY_ID", applyId);
			DataSet ds = dao.query(param);
			if(ds != null && ds.getCount() !=0) {
				dataBean = (Demobilizedflow)(ds.getRecord(0).toBean(Demobilizedflow.class));
				bptApplyHistory.setApplyAdvice(dataBean.getTownViews());
				bptApplyHistory.setApplyIncharge(dataBean.getTrialName());
				bptApplyHistory.setApplyTime(dataBean.getTrialDate());
				bptApplyHistory.setApplyFlag(dataBean.getTownFlag());
				bptApplyHistory.setReport(dataBean.getTownReport());
				
				//乡审批意见
				bptApplyHistory.setApplyTownAdvice(dataBean.getCountiesViews());
				bptApplyHistory.setApplyTownIncharge(dataBean.getTrialName());
				bptApplyHistory.setApplyTownTime(dataBean.getTrialDate());
			}
		} else if("city".equals(currentField)) { //市级
			bptApplyHistory.setApplyAdvice(dataBean.getCitiesViews());
			bptApplyHistory.setApplyIncharge(dataBean.getApprovalName());
			bptApplyHistory.setApplyTime(dataBean.getApprovalDate());
			bptApplyHistory.setApplyFlag(dataBean.getCityFlag());
		}
		bptApplyHistoryService.insert(bptApplyHistory);
	}
	
	/**
	 * 流程完成后更新人员基本信息以及三属信息
	 */
	@Trans
	public void updateInfo(String StateCode) {
		String peopleId = (String) getParameter("peopleId");
		String serviceType = (String)getParameter("serviceType");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("PEOPLE_ID", peopleId);
		BaseinfoPeople baseinfoPeople = (BaseinfoPeople) service.queryPeople(
				pset).getRecord(0).toBean(BaseinfoPeople.class);
		String domicileCode=baseinfoPeople.getDomicileCode();
		if ("41".equals(serviceType)) { // 在乡复员
			BptPeopleDemobilized demobilized = (BptPeopleDemobilized) demobilizedService
					.query(pset).getRecord(0).toBean(BptPeopleDemobilized.class);
			baseinfoPeople.setDemobilizedStateCode(StateCode);
			demobilized.setApprovalDate(DateUtil.getDay());
			demobilizedService.updateBptPeopleDemobilized(demobilized);
			if("2".equals(StateCode)){//予以评定
				baseinfoPeople.setDemobilizedNo(NOService.getNO("ZX",domicileCode));
			}
			insertStateChange(baseinfoPeople,"1",StateCode,"41");
		} else if ("45".equals(serviceType)) { //带病回乡
			BptPeopleDemobilizedIllness demobilizedIllness = (BptPeopleDemobilizedIllness) demobilizedIllnessService.query(pset)
					.getRecord(0).toBean(BptPeopleDemobilizedIllness.class);
			baseinfoPeople.setDemobilizedStateCode(StateCode);
			demobilizedIllness.setApprovalDate(DateUtil.getDay());
			demobilizedIllnessService.updateBptPeopleDemobilizedIllness(demobilizedIllness);
			if("2".equals(StateCode)){//予以评定
				baseinfoPeople.setDemobilizedNo(NOService.getNO("DB",domicileCode));
			}
			insertStateChange(baseinfoPeople,"1",StateCode,"45");
			//baseinfoPeople.setWarStateCode("2");
			//baseinfoPeople.setWarNo(commNo);01	革命伤残军人
		}
		service.updateBaseinfoPeople(baseinfoPeople); // 修改人员基本信息
	}

public String findCommNo(String peopleId) {

	return "鲁军00002";
}
/**
 * 添加状态变更表数据
 * @param baseinfoPeople
 * @param prestate
 * @param endstate
 * @param serviceType
 */
public void insertStateChange(BaseinfoPeople baseinfoPeople ,String prestate,String endstate,String serviceType){
	// 状态变更接口
	 IBptStateChangeDomain stateChangeService = ScaComponentFactory
			.getService(IBptStateChangeDomain.class,
					"bptStateChangeDomain/bptStateChangeDomain");
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
