package com.inspur.cams.bpt.manage.cmd;

import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;
import org.loushang.workflow.api.WfTaskRequestWrapper;

import com.inspur.cams.bpt.base.data.BptApplyDependant;
import com.inspur.cams.bpt.base.data.BptPeopleDependant;
import com.inspur.cams.bpt.base.data.BptPeopleTested;
import com.inspur.cams.bpt.base.data.BptPeopleWar;
import com.inspur.cams.bpt.base.domain.IBptApplyDependantDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDependantDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleTestedDomain;
import com.inspur.cams.bpt.base.domain.IWarDomain;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.util.DateUtil;

/**
 * 三属申请command
 * 
 * @author zhanghui
 * 
 */
public class BptApplyDependantCommand extends BaseAjaxCommand {

	IBptGroupDomain service = ScaComponentFactory.getService(
			IBptGroupDomain.class, "bptGroupDomain/bptGroupDomain");

	/**
	 * 三属服务接口
	 */
	IBptPeopleDependantDomain dependantService = ScaComponentFactory
			.getService(IBptPeopleDependantDomain.class,
					"bptPeopleDependantDomain/bptPeopleDependantDomain");

	/**
	 * 获得优抚人员服务接口
	 */
	IBptPeopleDomain bptPeopleService = ScaComponentFactory.getService(
			IBptPeopleDomain.class, "bptPeopleDomain/bptPeopleDomain");

	/**
	 * 工作流信息服务接口
	 */
	IWfProcessBusinessDomain wfProcessBusinessService = ScaComponentFactory
			.getService(IWfProcessBusinessDomain.class,
					"wfProcessBusinessDomain/wfProcessBusinessDomain");

	/**
	 * 获得参试人员服务接口
	 */
	IBptPeopleTestedDomain bptPeopleTestedService = ScaComponentFactory
			.getService(IBptPeopleTestedDomain.class,
					"bptPeopleTestedDomain/bptPeopleTestedDomain");

	IWarDomain iWarService = ScaComponentFactory.getService(IWarDomain.class,
			"bptWarDomain/bptWarDomain");

	/**
	 * 三属人员申请接口
	 */
	private IBptApplyDependantDomain bptApplyService = ScaComponentFactory
			.getService(IBptApplyDependantDomain.class,
					"bptApplyDependantDomain/bptApplyDependantDomain");

	//删除三属
	@Trans
	public void deleteDependant(){
		Record[] records = (Record[]) getParameter("record");
		for (Record record : records) {
			String applyId =(String)record.get("APPLY_ID");
			String peopleId =(String)record.get("PEOPLE_ID");
			ParameterSet pst = new ParameterSet();
			pst.setParameter("applyId", applyId);
			pst.setParameter("peopleId", peopleId);
			bptApplyService.deleteDependant(pst);
		}
		
	}
	//保存三属参战参试申请审批
	@Trans
	public void saveDependant(){
		Record[] records = (Record[]) getParameter("records");
		for (Record record : records) {
			BptApplyDependant bptApplyDependant=(BptApplyDependant)record.toBean(BptApplyDependant.class);
			bptApplyService.update(bptApplyDependant);
			
		}
	}
	//判定三属参战参试申请审批是否保存
	public void isSave(){
		String applyId = (String) getParameter("applyId");
		ParameterSet pset= new ParameterSet();
		pset.setParameter("APPLY_ID", applyId);
		DataSet ds =bptApplyService.queryApplyDependant(pset);
		if(ds.getCount()==1){
			String countiesAduitIncharge=(String)ds.getRecord(0).get("countiesAduitIncharge");
			String isApprove=(String)ds.getRecord(0).get("isApprove");
			String isSure=(String)ds.getRecord(0).get("isSure");
			if(!"".equals(countiesAduitIncharge)&&countiesAduitIncharge!=null){
				this.setReturn("save", true);
				this.setReturn("isApprove", isApprove);
				this.setReturn("isSure", isSure);
			}else{
				this.setReturn("save", false);
			}
		}else{
			this.setReturn("save", false);
		}
	}
	/**
	 * 修改三属人员申请审批信息
	 */
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		BptApplyDependant bptApplyDependant = new BptApplyDependant();

		// 封装三属人员申请审批信息
		bptApplyDependant.setApplyId((String) record.get("APPLY_ID"));
		bptApplyDependant.setPeopleId((String) record.get("PEOPLE_ID"));
		bptApplyDependant.setApproveDate((String) record.get("APPROVE_DATE"));
		bptApplyDependant.setApproveOrganId((String) record
				.get("APPROVE_ORGAN_ID"));
		bptApplyDependant.setCommitFlag((String) record.get("COMMIT_FLAG"));
		bptApplyDependant.setServiceType((String) record.get("SERVICE_TYPE"));
		bptApplyDependant.setTownAduitAdvice((String) record
				.get("TOWN_ADUIT_ADVICE"));
		bptApplyDependant.setTownAduitApproveDate((String) record
				.get("TOWN_ADUIT_APPROVE_DATE"));
		bptApplyDependant.setTownAduitIncharge((String) record
				.get("TOWN_ADUIT_INCHARGE"));
		bptApplyDependant.setObjectType((String) record.get("OBJECT_TYPE"));

		bptApplyService.update(bptApplyDependant);
	}

	/**
	 * 发送流程
	 */
	@Trans
	public void send() {
		Map map = WfTaskRequestWrapper.getInstance().send();

		if (map.containsKey("isEnd")) { // 流程完成后修改三属信息
			String isEnd = (String) map.get("isEnd");
			if ("true".equals(isEnd)) {
				updateInfo();
			}
		}
	}

	/**
	 * 回退流程
	 */
	@Trans
	public void back() {
		WfTaskRequestWrapper.getInstance().back();
	}

	/**
	 * 生成三属、参试、参战抚恤编号
	 * 
	 * @param peopleId
	 * @return
	 */
	public String findCommNo(String peopleId) {

		return "鲁军00001";
	}

	/**
	 * 流程完成后更新人员基本信息以及三属信息
	 */
	@Trans
	public void updateInfo() {
		String peopleId = (String) getParameter("peopleId");
		String object_type = (String) getParameter("object_type"); // 业务类型
		String commNo = findCommNo(peopleId);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("PEOPLE_ID", peopleId);
		BaseinfoPeople baseinfoPeople = (BaseinfoPeople) service.queryPeople(
				pset).getRecord(0).toBean(BaseinfoPeople.class);

		if ("2".equals(object_type)) { // 三属
			BptPeopleDependant dependant = (BptPeopleDependant) dependantService
					.query(pset).getRecord(0).toBean(BptPeopleDependant.class);
			dependant.setApprovalDate(DateUtil.getDay());
			dependantService.update(dependant);

			baseinfoPeople.setDependantStateCode("2");// 状态设置为享受待遇
			baseinfoPeople.setDependantNo(commNo);
		} else if ("5".equals(object_type)) { // 参战
			BptPeopleWar bptPeopleWar = (BptPeopleWar) iWarService.query(pset)
					.getRecord(0).toBean(BptPeopleWar.class);
			bptPeopleWar.setApprovalDate(DateUtil.getDay());
			iWarService.updateWar(bptPeopleWar);
			
			baseinfoPeople.setWarStateCode("2");
			baseinfoPeople.setWarNo(commNo);
		} else if ("6".equals(object_type)) { // 参试
			BptPeopleTested test = (BptPeopleTested) bptPeopleTestedService
					.queryPeopleTested(pset).getRecord(0).toBean(
							BptPeopleTested.class);
			test.setApprovalDate(DateUtil.getDay());
			bptPeopleTestedService.updatePeopleTeseted(test);

			baseinfoPeople.setWarStateCode("2");
			baseinfoPeople.setWarNo(commNo);

		}
		service.updateBaseinfoPeople(baseinfoPeople); // 修改人员基本信息
	}
}
