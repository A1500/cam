package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.sam.domain.ISamApplyFilesDomain;

/**
 * @title:申请材料QueryCommand
 * @description:
 * @author:
 * @since:2012-05-05
 * @version:1.0
*/
public class SamApplyFilesQueryCmd extends BaseQueryCommand{
	ISamApplyFilesDomain samApplyFilesDomain = ScaComponentFactory.getService(ISamApplyFilesDomain.class, "samApplyFilesDomain/samApplyFilesDomain");
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samApplyFilesDomain.query(pset);
	}
}
