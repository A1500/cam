package com.inspur.cams.sorg.jxcheck.somjxextrarebuild.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxExtraRebuildDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxExtraRebuildDao extends BaseCURD<SomJxExtraRebuild>{
	public void save(List<SomJxExtraRebuild> list);
}

