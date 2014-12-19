package com.inspur.cams.drel.surey.assistance.cmd;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.surey.assistance.domain.ISamAssistanceDomain;
import com.inspur.cams.drel.surey.comm.data.SamSureyWf;

public class SamAssistanceCmd extends BaseAjaxCommand{
	// 获取SCA组件
	private ISamAssistanceDomain service = ScaComponentFactory.getService(ISamAssistanceDomain.class,"SamAssistanceDomain/SamAssistanceDomain");
	
	//创建新业务
	public void insertSurey(){
		Record record = (Record) getParameter("record");
		SamSureyWf sureyWfBean = (SamSureyWf) record.toBean(SamSureyWf.class);
		
		String applyOrganName = (String) getParameter("applyOrganName");
		String organId = (String) getParameter("organId");
		String applyOrganType = (String) getParameter("organType");
		String applyOrganArea = (String) getParameter("organArea");
		
		sureyWfBean.setCurActivityOrgan(organId);
		sureyWfBean.setCurActivityOrganName(applyOrganName);
		sureyWfBean.setCurActivityOrganType(applyOrganType);
		sureyWfBean.setCurActivityArea(applyOrganArea);
		
		service.insertSurey(sureyWfBean);
	}
	//删除业务及流程
	public void deleteSurey(){
		Record[] records = (Record[]) getParameter("records");
		service.deleteSurey(records);
	}
	//更新业务
	public void updateSurey(){
		Record record = (Record) getParameter("record");
		String peopleId = (String) getParameter("peopleId");
		SamSureyWf wfBean = (SamSureyWf) record.toBean(SamSureyWf.class);
		Map<String, String> map = new HashMap<String, String>();
		map.put("peopleId", peopleId);
		service.updateSurey(wfBean,map);
	}
	//提交业务到下一环节
	public void sendSurey(){
		List<String> flowIdList = new ArrayList<String>();
		Record[] records = (Record[]) getParameter("records");
		for (int i = 0; i < records.length; i++) {
			String flowId = (String) records[i].get("FLOW_ID");
			flowIdList.add(flowId);
		}
		String userName = (String) getParameter("userName");
		String userId = (String) getParameter("userId");
		service.sendSurey(flowIdList,userId,userName);
	}
}
