package com.inspur.cams.drel.archive.samfamilyestatearchive.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.archive.samfamilyestatearchive.data.SamFamilyEstateArchive;
import com.inspur.cams.drel.archive.samfamilyestatearchive.domain.ISamFamilyEstateArchiveDomain;

/**
 * 家庭财产信息cmd
 * @author 
 * @date 2012-06-28
 */
public class SamFamilyEstateArchiveCmd extends BaseAjaxCommand {

	private ISamFamilyEstateArchiveDomain samFamilyEstateArchiveDomain = ScaComponentFactory
			.getService(ISamFamilyEstateArchiveDomain.class, "samFamilyEstateArchiveDomain/samFamilyEstateArchiveDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		SamFamilyEstateArchive samFamilyEstateArchive = (SamFamilyEstateArchive) record.toBean(SamFamilyEstateArchive.class);
		samFamilyEstateArchiveDomain.insert(samFamilyEstateArchive);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		SamFamilyEstateArchive samFamilyEstateArchive = (SamFamilyEstateArchive) record.toBean(SamFamilyEstateArchive.class);
		samFamilyEstateArchiveDomain.update(samFamilyEstateArchive);
	}
	
	// 删除
	public void delete() {
		String estateId = (String) getParameter("estateId");
		samFamilyEstateArchiveDomain.delete(estateId);
	}
	
}