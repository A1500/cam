package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.data.FisCemeteryOrgan;
import com.inspur.cams.fis.base.domain.IFisCemeteryOrganDomain;

/**
 * @Path com.inspur.cams.fis.base.cmd.FisCemeteryOrganCmd
 * @Description: TODO 殡葬业务公墓信息表Cmd
 * @author muqi
 * @date 2012-04-09
 */
public class FisCemeteryOrganCmd extends BaseAjaxCommand {
	IFisCemeteryOrganDomain service = ScaComponentFactory.getService(
			IFisCemeteryOrganDomain.class,
			"FisCemeteryOrganDomain/FisCemeteryOrganDomain");
	
	public void update(){
		Record record = (Record) getParameter("record");
		FisCemeteryOrgan bean = (FisCemeteryOrgan) record.toBean(FisCemeteryOrgan.class);
		service.update(bean);
	}
	public void insert(){
		Record record = (Record) getParameter("record");
		FisCemeteryOrgan bean = (FisCemeteryOrgan) record.toBean(FisCemeteryOrgan.class);
		service.insert(bean);
	}
}
