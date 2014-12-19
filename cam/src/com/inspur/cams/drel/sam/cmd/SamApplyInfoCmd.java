package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.sam.data.SamApplyInfo;
import com.inspur.cams.drel.sam.domain.ISamApplyInfoDomain;

/**
 * @title:低保申请审批信息Cmd
 * @description:
 * @author:	yanliangliang
 * @since:2012-05-02
 * @version:1.0
*/
public class SamApplyInfoCmd extends BaseAjaxCommand{
	private ISamApplyInfoDomain samApplyInfoDomain = ScaComponentFactory.getService(ISamApplyInfoDomain.class, "samApplyInfoDomain/samApplyInfoDomain");

	public void insert() {
		Record record = (Record) getParameter("record");
		SamApplyInfo dataBean=(SamApplyInfo)record.toBean(SamApplyInfo.class);
		samApplyInfoDomain.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SamApplyInfo dataBean=(SamApplyInfo)record.toBean(SamApplyInfo.class);
		samApplyInfoDomain.update(dataBean);
	}
	/**
	 * 根据主键删除业务信息
	 * @param applyId
	 */
	public void deleteSamApply(){
		String applyId=(String)getParameter("APPLY_ID");
		samApplyInfoDomain.deleteSamApply(applyId);
	}
	/**
	 * 获取最低生活保障标准
	 */
	public void getAssistanceMoney(){
		ParameterSet pset = getParameterSet();
		String lowStandards=samApplyInfoDomain.getAssistanceMoney(pset).toString();
		setReturn("lowStandards",lowStandards) ;
	}
	
}
