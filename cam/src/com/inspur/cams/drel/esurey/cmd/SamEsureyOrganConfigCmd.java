package com.inspur.cams.drel.esurey.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.esurey.data.SamEsureyOrganConfig;
import com.inspur.cams.drel.esurey.domain.ISamEsureyOrganConfigDomain;

/**
 * @title:SamEsureyOrganConfigCommand
 * @description:
 * @author:
 * @since:2011-07-05
 * @version:1.0
*/
public class SamEsureyOrganConfigCmd extends BaseAjaxCommand{
	private ISamEsureyOrganConfigDomain samEsureyOrganConfigDomain = 
		ScaComponentFactory.getService(ISamEsureyOrganConfigDomain.class,
				"SamEsureyOrganConfigDomain/SamEsureyOrganConfigDomain");

	
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SamEsureyOrganConfig> list = new ArrayList<SamEsureyOrganConfig>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SamEsureyOrganConfig dataBean = (SamEsureyOrganConfig) records[i].toBean(SamEsureyOrganConfig.class);
			list.add(dataBean);
		}

		samEsureyOrganConfigDomain.save(list);
	}
}
