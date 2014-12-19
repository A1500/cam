package com.inspur.cams.drel.archive.samfamilyhousearchive.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.archive.samfamilyhousearchive.data.SamFamilyHouseArchive;
import com.inspur.cams.drel.archive.samfamilyhousearchive.domain.ISamFamilyHouseArchiveDomain;

/**
 * 基础信息_房屋信息cmd
 * @author 
 * @date 2012-06-28
 */
public class SamFamilyHouseArchiveCmd extends BaseAjaxCommand {

	private ISamFamilyHouseArchiveDomain samFamilyHouseArchiveDomain = ScaComponentFactory
			.getService(ISamFamilyHouseArchiveDomain.class, "samFamilyHouseArchiveDomain/samFamilyHouseArchiveDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		SamFamilyHouseArchive samFamilyHouseArchive = (SamFamilyHouseArchive) record.toBean(SamFamilyHouseArchive.class);
		samFamilyHouseArchiveDomain.insert(samFamilyHouseArchive);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		SamFamilyHouseArchive samFamilyHouseArchive = (SamFamilyHouseArchive) record.toBean(SamFamilyHouseArchive.class);
		samFamilyHouseArchiveDomain.update(samFamilyHouseArchive);
	}
	
	// 删除
	public void delete() {
		String houseArchiveId = (String) getParameter("houseArchiveId");
		samFamilyHouseArchiveDomain.delete(houseArchiveId);
	}
	
}