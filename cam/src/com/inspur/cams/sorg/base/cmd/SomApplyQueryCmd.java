package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;

/**
 * 业务信息查询cmd
 * @author shgtch
 * @date 2011-8-12
 */
public class SomApplyQueryCmd extends BaseQueryCommand {

	ISomApplyDomain somApplyDomain = ScaComponentFactory.getService(ISomApplyDomain.class, "SomApplyDomain/SomApplyDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return somApplyDomain.query(pset);
	}
	public DataSet queryHisChange() {
		ParameterSet pset = getParameterSet();
		//String morgArea=BspUtil.getCorpOrgan().getOrganCode();
		//pset.setParameter("MORG_AREA",getMorgAreaCode(morgArea));
		return somApplyDomain.queryHisChange(pset);
	}
	public DataSet querySorgApply(){
		ParameterSet pset = getParameterSet();
		return somApplyDomain.querySorgApply(pset);
	}
	/**
	 * 查询带有社会组织信息的流程信息
	 * @return
	 */
	public DataSet queryOrgan(){
		ParameterSet pset = getParameterSet();
		return somApplyDomain.queryOrgan(pset);
	}
}