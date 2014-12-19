package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.sam.domain.ISamTreatmentAdjustDomain;

/**
 * @title:待遇调整记录查询Command
 * @description:
 * @author: zhangjian
 * @since:2012-06-08
 * @version:1.0
*/
public class SamTreatmentAdjustQueryCmd extends BaseQueryCommand {
	private ISamTreatmentAdjustDomain service = ScaComponentFactory.getService(ISamTreatmentAdjustDomain.class, "samTreatmentAdjustDomain/samTreatmentAdjustDomain");
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}
}
