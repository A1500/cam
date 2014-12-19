package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisResourceTypeDomain;

/**
 * @Path com.inspur.cams.fis.base.cmd.FisResourceTypeQueryCmd  
 * @Description: TODO 殡葬业务资源分类表QueryCmd
 * @author wangziming
 * @date 2011-11-15
 */
public class FisResourceTypeQueryCmd extends BaseQueryCommand{
	
	IFisResourceTypeDomain service = ScaComponentFactory.getService(IFisResourceTypeDomain.class,
	"FisResourceTypeDomain/FisResourceTypeDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		DataSet ds=service.query(pset);
		ds.getMetaData().setIdProperty("resourceType");
		return ds;
	}
}