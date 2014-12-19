package com.inspur.cams.drel.organ.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.organ.date.SamSupportOrgan;
import com.inspur.cams.drel.organ.domain.ISamSupportOrganDomain;

/**
 * @title:SamSupportOrganCommand
 * @description:
 * @author:
 * @since:2012-05-21
 * @version:1.0
*/
public class SamSupportOrganCmd extends BaseAjaxCommand{
	private ISamSupportOrganDomain samSupportOrganDomain = 
		ScaComponentFactory.getService(ISamSupportOrganDomain.class,
				"samSupportOrganDomain/samSupportOrganDomain");
	/**
	 * 保存
	 */
	public void save(){		
		Record record = (Record) getParameter("record");
		SamSupportOrgan organ =  (SamSupportOrgan) record.toBean(SamSupportOrgan.class);
		String organId = organ.getOrganId();
		if (organId==null||"".equals(organId)) {
			organ.setOrganId(IdHelp.getUUID32());
			samSupportOrganDomain.insert(organ);
		}else {
			samSupportOrganDomain.update(organ);			
		}
	}
	public void insert(){
		
		Record record = (Record) getParameter("record");
		SamSupportOrgan organ =  (SamSupportOrgan) record.toBean(SamSupportOrgan.class);
		samSupportOrganDomain.insert(organ);
	}
	
	public void update(){
		
		Record record = (Record) getParameter("record");
		SamSupportOrgan organ =  (SamSupportOrgan) record.toBean(SamSupportOrgan.class);
		samSupportOrganDomain.update(organ);
	}
	public void delete(){		
		String organId = (String) getParameter("organId");
		samSupportOrganDomain.delete(organId);
	}
}
