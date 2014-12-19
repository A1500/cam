package com.inspur.cams.comm.informUtil;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IPubOrganDao
 * @description:
 * @author:
 * @since:2010-12-04
 * @version:1.0
*/
 public interface InformIPubOrganDao extends BaseCURD<InformPubOrgan>{
	public void save(List<InformPubOrgan> list);
}

