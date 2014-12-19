package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisResourceLevelDomain;
/**
 * @Path com.inspur.cams.fis.base.cmd.FisResourceLevelQueryCmd  
 * @Description: TODO 殡葬业务资源级别定义QueryCmd
 * @author wangziming
 * @date 2011-11-15
 */
public class FisResourceLevelQueryCmd extends BaseQueryCommand{
	
	IFisResourceLevelDomain service = ScaComponentFactory.getService(IFisResourceLevelDomain.class,
	"FisResourceLevelDomain/FisResourceLevelDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		DataSet ds=service.query(pset);
		ds.getMetaData().setIdProperty("levelId");
		return ds;
	}
}