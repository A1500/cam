package com.inspur.cams.drel.archive.baseinfofamilyarchive.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.archive.baseinfofamilyarchive.data.BaseinfoFamilyArchive;

/**
 * @title:IBaseinfoFamilyArchiveDao
 * @description:
 * @author:
 * @since:2012-05-30
 * @version:1.0
*/
 public interface IBaseinfoFamilyArchiveDao extends BaseCURD<BaseinfoFamilyArchive>{
	public void save(List<BaseinfoFamilyArchive> list);
}

