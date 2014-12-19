package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.data.BptApplyMartyrOffspring;
import com.inspur.cams.bpt.base.data.BptPeopleMartyrOffspring;
import com.inspur.cams.bpt.base.data.BptStateChange;
import com.inspur.cams.bpt.base.domain.IBptApplyMartyrOffspringDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleMartyrOffspringDomain;
import com.inspur.cams.bpt.base.domain.IBptStateChangeDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:BptApplyMartyrOffspringCommand
 * @description:
 * @author:
 * @since:
 * @version:
*/
public class BptApplyMartyrOffspringCommand extends BaseAjaxCommand{
	// 状态变更接口
	private IBptStateChangeDomain stateChangeService = ScaComponentFactory
			.getService(IBptStateChangeDomain.class,
					"bptStateChangeDomain/bptStateChangeDomain");
	/**
	 *  修改部分烈士（错杀被平反人员）子女申请信息
	 */
	 @Trans
	public void update(){
		 IBptApplyMartyrOffspringDomain applyMartyrOffspringDomain = (IBptApplyMartyrOffspringDomain)ScaComponentFactory.getService(IBptApplyMartyrOffspringDomain.class,"bptApplyMartyrOffspringDomain/bptApplyMartyrOffspringDomain");
		BptApplyMartyrOffspring bean = (BptApplyMartyrOffspring)((Record)getParameter("record")).toBean(BptApplyMartyrOffspring.class);
		applyMartyrOffspringDomain.update(bean);
	}
	 
	 /**
	  * 删除部分烈士（错杀被平反人员）子女申请信息
	  */
	@Trans
	public void deleteMartyrOffspring(){
		IBptApplyMartyrOffspringDomain applyMartyrOffspringDomain = (IBptApplyMartyrOffspringDomain)ScaComponentFactory.getService(IBptApplyMartyrOffspringDomain.class,"bptApplyMartyrOffspringDomain/bptApplyMartyrOffspringDomain");
		Record[] records = (Record[])getParameter("records");
		for(Record rd:records){
			String applyId = (String)rd.get("APPLY_ID");
			String peopleId = (String)rd.get("PEOPLE_ID");
			ParameterSet pset = new ParameterSet();
			pset.setParameter("applyId", applyId);
			pset.setParameter("peopleId", peopleId);
			applyMartyrOffspringDomain.deleteMartyrOffspring(pset);
		}
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
		IBptApplyMartyrOffspringDomain applyMartyrOffspringDomain = (IBptApplyMartyrOffspringDomain)ScaComponentFactory.getService(IBptApplyMartyrOffspringDomain.class,"bptApplyMartyrOffspringDomain/bptApplyMartyrOffspringDomain");
		DataSet ds = applyMartyrOffspringDomain.query(pset);
		if(ds.getCount()>0){
			String auditIncharge = (String)ds.getRecord(0).get("auditIncharge");
			if(auditIncharge!=null&&!"".equals(auditIncharge)){
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
		IBptApplyMartyrOffspringDomain applyMartyrOffspringDomain = (IBptApplyMartyrOffspringDomain)ScaComponentFactory.getService(IBptApplyMartyrOffspringDomain.class,"bptApplyMartyrOffspringDomain/bptApplyMartyrOffspringDomain");
		DataSet ds = applyMartyrOffspringDomain.query(pset);
		BptApplyMartyrOffspring bean = (BptApplyMartyrOffspring)((Record)ds.getRecord(0)).toBean(BptApplyMartyrOffspring.class);
		bean.setApplyDate(DateUtil.getDay());
		bean.setApproveOrganId(BspUtil.getOrganCode());
		bean.setCommitFlag("1");
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		applyMartyrOffspringDomain.update(bean);
		
		String peopleId = bean.getPeopleId();
		ParameterSet pset1 = new ParameterSet();
		pset1.setParameter("PEOPLE_ID",peopleId);
		//更新老烈士子女类别信息
		IBptPeopleMartyrOffspringDomain martyrOffspringDomain = (IBptPeopleMartyrOffspringDomain)ScaComponentFactory.getService(IBptPeopleMartyrOffspringDomain.class, "bptPeopleMartyrOffspringDomain/bptPeopleMartyrOffspringDomain");
		BptPeopleMartyrOffspring martyOffspringBean = (BptPeopleMartyrOffspring)martyrOffspringDomain.query(pset1).getRecord(0).toBean(BptPeopleMartyrOffspring.class);
		martyOffspringBean.setApprovalDate(DateUtil.getDay());
		martyOffspringBean.setModId(BspUtil.getEmpOrganId());
		martyOffspringBean.setModTime(DateUtil.getTime());
		martyrOffspringDomain.update(martyOffspringBean);
		//更新优抚对象状态
		String agreeFlag = bean.getAgreeFlag();
		IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class, "bptGroupDomain/bptGroupDomain");
		BaseinfoPeople peopleBean = (BaseinfoPeople)service.queryPeople(pset1).getRecord(0).toBean(BaseinfoPeople.class);
		if("0".equals(agreeFlag)){
			peopleBean.setMartyrOffspringStateCode("2");
			insertStateChange(peopleBean,"1","2","B1");
		}else if("1".equals(agreeFlag)){
			peopleBean.setMartyrOffspringStateCode("6");
			insertStateChange(peopleBean,"1","6","B1");
		}
		peopleBean.setModId(BspUtil.getEmpOrganId());
		peopleBean.setModTime(DateUtil.getTime());
		service.updateBaseinfoPeople(peopleBean);
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
