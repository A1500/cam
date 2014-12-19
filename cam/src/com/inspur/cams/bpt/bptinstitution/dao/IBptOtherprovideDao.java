package com.inspur.cams.bpt.bptinstitution.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import com.inspur.cams.bpt.bptinstitution.data.BptOtherprovide;
/**
 * @title:IBptOtherprovideDao
 * @description:
 * @author:
 * @since:2011-12-05
 * @version:1.0
*/
 public interface IBptOtherprovideDao extends BaseCURD<BptOtherprovide>{
	public void save(List<BptOtherprovide> list);
}

