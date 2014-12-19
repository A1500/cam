package com.inspur.cams.drel.archive.samfamilysupportarchive.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.archive.samfamilysupportarchive.data.SamFamilySupportArchive;
import com.inspur.cams.drel.archive.samfamilysupportarchive.domain.ISamFamilySupportArchiveDomain;

/**
 * 赡扶抚养人cmd
 * @author 
 * @date 2012-06-28
 */
public class SamFamilySupportArchiveCmd extends BaseAjaxCommand {

	private ISamFamilySupportArchiveDomain samFamilySupportArchiveDomain = ScaComponentFactory
			.getService(ISamFamilySupportArchiveDomain.class, "samFamilySupportArchiveDomain/samFamilySupportArchiveDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		SamFamilySupportArchive samFamilySupportArchive = (SamFamilySupportArchive) record.toBean(SamFamilySupportArchive.class);
		samFamilySupportArchiveDomain.insert(samFamilySupportArchive);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		SamFamilySupportArchive samFamilySupportArchive = (SamFamilySupportArchive) record.toBean(SamFamilySupportArchive.class);
		samFamilySupportArchiveDomain.update(samFamilySupportArchive);
	}
	
	// 删除
	public void delete() {
		String supportArchiveId = (String) getParameter("supportArchiveId");
		samFamilySupportArchiveDomain.delete(supportArchiveId);
	}
	
}