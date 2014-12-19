package com.inspur.cams.drel.config.assistance.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.drel.config.assistance.data.SamAssistanceClass;
import com.inspur.cams.drel.config.assistance.domain.ISamAssistanceClassDomain;

/**
 * @title:分类施保配置cmd
 * @description:
 * @author:
 * @since:2012-05-02
 * @version:1.0
 */
public class SamAssistanceClassCmd extends BaseAjaxCommand {
	private ISamAssistanceClassDomain samAssistanceClassDomain = ScaComponentFactory.getService(ISamAssistanceClassDomain.class, "samAssistanceClassDomain/samAssistanceClassDomain");
	public void save(){
		Record assistanceClassRecord = (Record) getParameter("assistanceClassRecord");
		SamAssistanceClass samAssistanceClass=(SamAssistanceClass) assistanceClassRecord.toBean(SamAssistanceClass.class);
		//如果主键为空，为新增记录
		if("".equals(StrUtil.n2b(samAssistanceClass.getAssistanceClassId()))){
			samAssistanceClass.setAssistanceClassId(IdHelp.getUUID30());
			samAssistanceClass.setRegPeople(BspUtil.getEmpOrgan().getOrganName());
			samAssistanceClass.setRegOrgan(BspUtil.getOrganName());
			samAssistanceClass.setRegTime(DateUtil.getTime());
			samAssistanceClassDomain.insert(samAssistanceClass);
		} else {
			//如果主键不为空，则停用原分类施保类别
			SamAssistanceClass oriAssistanceClass = samAssistanceClassDomain.get(samAssistanceClass.getAssistanceClassId());
			oriAssistanceClass.setEndDate(DateUtil.getYestedayDate(DateUtil.getDay()));
			oriAssistanceClass.setInUse("0");
			samAssistanceClassDomain.update(oriAssistanceClass);
			//新增分类施保类别，为启用状态
			samAssistanceClass.setAssistanceClassId(IdHelp.getUUID30());
			samAssistanceClass.setInUse("1");
			samAssistanceClass.setBeginDate(DateUtil.getDay());
			samAssistanceClass.setRegPeople(BspUtil.getEmpOrgan().getOrganName());//录入人
			samAssistanceClass.setRegOrgan(BspUtil.getOrganName());//录入单位
			samAssistanceClass.setRegTime(DateUtil.getTime());//录入时间
			samAssistanceClassDomain.insert(samAssistanceClass);
		}
	}
	public void delete(){
		String assistanceClassId = (String) getParameter("assistanceClassId");
		samAssistanceClassDomain.delete(assistanceClassId);
	}
	public void stop(){
		Record assistanceClassRecord = (Record) getParameter("assistanceClassRecord");
		SamAssistanceClass samAssistanceClass=(SamAssistanceClass) assistanceClassRecord.toBean(SamAssistanceClass.class);
		samAssistanceClass.setInUse("0");
		samAssistanceClass.setEndDate(DateUtil.getDay());
		samAssistanceClassDomain.update(samAssistanceClass);
	}
	/**
	 * 根据分类施保类别回填分类施保金
	 * @return
	 */
	public void getClassMoney(){
		ParameterSet pset = getParameterSet();
		setReturn("classMoney", samAssistanceClassDomain.getClassMoney(pset).getComputeValue());
		setReturn("classMode", samAssistanceClassDomain.getClassMoney(pset).getComputeMode());
	}
}
