package com.inspur.cams.drel.esurey.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.esurey.data.SamEsureyRelation;
import com.inspur.cams.drel.esurey.domain.ISamEsureyRelationDomain;

public class SamEsureyRelationCmd extends BaseAjaxCommand{
	private ISamEsureyRelationDomain service = ScaComponentFactory.getService(
			ISamEsureyRelationDomain.class, "SamEsureyRelationDomain/SamEsureyRelationDomain");
	
	public void insert(){
		Record record=(Record)getParameter("SamEsureyRelation");
		SamEsureyRelation bean=(SamEsureyRelation)record.toBean(SamEsureyRelation.class);			
		service.insert(bean);
	}
	
	public void update(){
		SamEsureyRelation bean= (SamEsureyRelation) getParameter("SamEsureyRelation");
		service.update(bean);
	}
}
