package com.inspur.cams.drel.mbalance.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.drel.mbalance.domain.ISamMedicalBeforeDomain;

/**
 * @title:SamMedicalBeforeQueryCommand
 * @description:医前救助查询command
 * @author:luguosui
 * @since:2011-06-25
 * @version:1.0
*/
public class SamMedicalBeforeQueryCmd extends BaseQueryCommand{
	private ISamMedicalBeforeDomain samMedicalBeforeDaoDomain=ScaComponentFactory.getService(ISamMedicalBeforeDomain.class, "samMedicalBeforeDomain/samMedicalBeforeDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		DataSet beforeDS= samMedicalBeforeDaoDomain.query(pset);
		for(int i=0;i<beforeDS.getCount();i++){	
			Record familyRecord=beforeDS.getRecord(i);
			//获取domicileName
			
			familyRecord.set("assitanceMon", StrUtil.changeTwoDecimal(familyRecord.get("assitanceMon").toString()));
		}
		return beforeDS;
	}
}
