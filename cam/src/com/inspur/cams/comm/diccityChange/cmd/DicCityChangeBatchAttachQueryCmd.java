package com.inspur.cams.comm.diccityChange.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.diccityChange.domain.IDicCityChangeBatchAttachDomain;

/**
 * 区划变更上传附件表查询cmd
 * @author 
 * @date 2014-01-13
 */
public class DicCityChangeBatchAttachQueryCmd extends BaseQueryCommand {

	private IDicCityChangeBatchAttachDomain dicCityChangeBatchAttachDomain = ScaComponentFactory
			.getService(IDicCityChangeBatchAttachDomain.class, "dicCityChangeBatchAttachDomain/dicCityChangeBatchAttachDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return dicCityChangeBatchAttachDomain.query(pset);
	}
	
}