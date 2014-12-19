package com.inspur.cams.comm.workflow.parser;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.bsp.share.organization.bean.StruView;
import org.loushang.next.dao.DaoFactory;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.workflow.engine.datafield.dao.IDataFieldDao;
import org.loushang.workflow.engine.datafield.data.DataField;
import org.loushang.workflow.engine.participant.activityparty.parser.IDataFieldActivityPartyParser;
import org.loushang.workflow.engine.process.dao.IProcessDao;
import org.loushang.workflow.engine.process.data.Process;
import org.loushang.workflow.util.LanguagePropertiesUtil;

import com.inspur.cams.comm.workflow.parser.dao.DataFieldRolePartyParserDao;
/***
 * 工作流解析参与者类扩展
 * 扩展原因：工作流定义的相关数据下的角色根据所传struId查找该struid对应的单位下所有的有这个角色的用户，包括下级单位的，现流程不需要包含下级
 * 单位的，此次扩展改为只查找struid对应的单位下不包括单位的有这个角色的用户
 * @author 赵锦
 * @date 2012-5-11
 */
public class DataFieldRolePartyParser implements  IDataFieldActivityPartyParser {
	private DataFieldRolePartyParserDao dao = (DataFieldRolePartyParserDao) DaoFactory
	.getDao(DataFieldRolePartyParserDao.class);

	/**
	 * 获取参与者
	 * 
	 * @param participantDefValue
	 *            数据项 作为参与者定义中的item-value
	 * @param procId
	 *            流程实例id
	 * @param creator
	 *            流程创建人
	 * @param preAssId
	 *            环节上一环节委派实例ID
	 * @param preActualOrganId
	 *            环节上一环节实际处理人organId
	 * @param preActDefUniqueId
	 *            环节上一环节定义唯一Id
	 * @return List 内容为Map,key分别为organId和organName
	 */
	
	
	//从context中获取相关数据值,然后解析相关数据下的角色
	public List getParties(String participantDefValue, String procId,
			String creator, String preAssId, String preActualOrganId,
			String preActDefUniqueId, Map context) {
		if (participantDefValue == null || "".equals(participantDefValue))
			throw new RuntimeException(LanguagePropertiesUtil
					.getProperty("参与者定义值为空！"));
		if(procId == null || "".equals(procId))
			throw new RuntimeException(LanguagePropertiesUtil
					.getProperty("流程实例ID为空！"));
		
		Process process = getProcessDao().get(procId);
		// 相关数据实例列表
		List dataFieldInstances = getDataFieldDao().getDataFieldList(
				process.getProcessId());
		//把相关数据实例放到Map中
		Map dataFieldInstancesMap = new HashMap();
		for(int i =0;i<dataFieldInstances.size();i++){
			DataField dataField =(DataField) dataFieldInstances.get(i);
			dataFieldInstancesMap.put(dataField.getDataFieldDefId(),dataField);
		}
		
		//解析participantDefValue
		String roleId = "";
		String dataFieldDefId ="";
		String[] itemValue = participantDefValue.split(":");
		//解析相关数据定义Id
		dataFieldDefId = itemValue[0];
		//要解析的角色
		roleId = itemValue[1];
		
		//优先从context中获取struId
		String struId = "";
		DataField dataField = (DataField)dataFieldInstancesMap.get(dataFieldDefId);
		if(context !=null && context.get(dataFieldDefId)!=null && 
			!"".equals((String)context.get(dataFieldDefId))){
			struId = (String)context.get(dataFieldDefId);
		}else if(dataField != null){
			struId = dataField.getValue();
		}else{
			throw new RuntimeException(LanguagePropertiesUtil
				.getProperty("WorkFlow.getDataFieldFail"));
		}
		
		List result = new ArrayList();
		//第三个参数为true则递归到下级，否则只包含本级
		StruView[] wfStruArray = dao.getUnderlingEmployeeByStruIdAndRoleId(struId,
				roleId,false);
		
		for (int i = 0; i < wfStruArray.length; i++) {
			StruView wfStru = wfStruArray[i];
			String organId = wfStru.getOrganId();
			if (organId != null && !"".equals(organId)) {
				Map map = new HashMap();
				map.put("organId", wfStru.getOrganId());
				map.put("organName", wfStru.getOrganName());
				result.add(map);
			}
		}
		return result;
	}
	
	protected static IDataFieldDao getDataFieldDao() {
		
			return ScaComponentFactory.getService(IDataFieldDao.class,
					"dataFieldDao/dataFieldDao");
	}
	
	protected static IProcessDao getProcessDao() {
		// 引擎中流程实例dao
		return ScaComponentFactory.getService(IProcessDao.class,
				"processDao/processDao");
	}


}
