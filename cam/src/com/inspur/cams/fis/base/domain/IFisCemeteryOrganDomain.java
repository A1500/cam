package com.inspur.cams.fis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisCemeteryOrgan;

/**
 * @Path com.inspur.cams.fis.base.domain.IFisCemeteryOrganDomain
 * @Description: TODO 殡葬业务公墓信息表Domain的接口
 * @author muqi
 * @date 2012-04-09
 */
public interface IFisCemeteryOrganDomain {
	public DataSet query(ParameterSet pset);
	
	@Trans
	public void update(FisCemeteryOrgan bean);

	public DataSet queryForExport(ParameterSet set);
	@Trans
	public void insert(FisCemeteryOrgan bean);
}
