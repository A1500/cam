package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisResourceFormatDomain;

/**
 * @Path com.inspur.cams.fis.base.cmd.FisResourceFormatQueryCmd  
 * @Description: TODO 殡葬业务资源规格QueryCmd
 * @author wangziming
 * @date 2011-11-15
 */
public class FisResourceFormatQueryCmd extends BaseQueryCommand{
	
	IFisResourceFormatDomain service = ScaComponentFactory.getService(IFisResourceFormatDomain.class,
	"FisResourceFormatDomain/FisResourceFormatDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}
}