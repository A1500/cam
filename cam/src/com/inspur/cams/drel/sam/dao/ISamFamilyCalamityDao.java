package com.inspur.cams.drel.sam.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import com.inspur.cams.drel.sam.data.SamFamilyCalamity;

/**
 * @title:自然灾害
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
 public interface ISamFamilyCalamityDao extends BaseCURD<SamFamilyCalamity>{
	public void save(List<SamFamilyCalamity> list);

	public void batchDeleteByYgjzJtxx(String[] jtid);

}

