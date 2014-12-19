package com.inspur.cams.drel.archive.samfamilyassistancearchive.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.archive.samfamilyassistancearchive.data.SamFamilyAssistanceArchive;
import com.inspur.cams.drel.archive.samfamilyassistancearchive.domain.ISamFamilyAssistanceArchiveDomain;

/**
 * 社会救助_救助基本信息cmd
 * @author 
 * @date 2012-06-28
 */
public class SamFamilyAssistanceArchiveCmd extends BaseAjaxCommand {

	private ISamFamilyAssistanceArchiveDomain samFamilyAssistanceArchiveDomain = ScaComponentFactory
			.getService(ISamFamilyAssistanceArchiveDomain.class, "samFamilyAssistanceArchiveDomain/samFamilyAssistanceArchiveDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		SamFamilyAssistanceArchive samFamilyAssistanceArchive = (SamFamilyAssistanceArchive) record.toBean(SamFamilyAssistanceArchive.class);
		samFamilyAssistanceArchiveDomain.insert(samFamilyAssistanceArchive);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		SamFamilyAssistanceArchive samFamilyAssistanceArchive = (SamFamilyAssistanceArchive) record.toBean(SamFamilyAssistanceArchive.class);
		samFamilyAssistanceArchiveDomain.update(samFamilyAssistanceArchive);
	}
	
	// 删除
	public void delete() {
		String familyArchiveId, familyId, assistanceType = (String) getParameter("familyArchiveId, familyId, assistanceType");
		samFamilyAssistanceArchiveDomain.delete(familyArchiveId, familyId, assistanceType);
	}
	
}