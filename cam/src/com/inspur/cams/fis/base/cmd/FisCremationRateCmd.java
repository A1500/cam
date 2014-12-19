package com.inspur.cams.fis.base.cmd;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.loushang.bsp.permit.menu.data.Menu;
import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.bsp.permit.pap.function.data.Operation;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.fis.base.data.FisCremationRate;
import com.inspur.cams.fis.base.domain.IFisCremationRateDomain;

/**
 * 火化率计算表cmd
 * 
 * @author
 * @date Thu Apr 19 18:46:28 GMT+08:00 2012
 */
public class FisCremationRateCmd extends BaseAjaxCommand {

	private IFisCremationRateDomain fisCremationRateDomain = ScaComponentFactory.getService(IFisCremationRateDomain.class, "fisCremationRateDomain/fisCremationRateDomain");

	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		FisCremationRate fisCremationRate = (FisCremationRate) record.toBean(FisCremationRate.class);
		fisCremationRate.setSumTime(DateUtil.getTime());
		fisCremationRate.setSumPeople(GetBspInfo.getBspInfo().getUserId());
		fisCremationRateDomain.insert(fisCremationRate);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		FisCremationRate fisCremationRate = (FisCremationRate) record.toBean(FisCremationRate.class);
		fisCremationRate.setSumTime(DateUtil.getTime());
		fisCremationRate.setSumPeople(GetBspInfo.getBspInfo().getUserId());
		fisCremationRateDomain.update(fisCremationRate);
	}

	// 删除
	public void delete() {
		String recordId = (String) getParameter("recordId");
		fisCremationRateDomain.delete(recordId);
	}

	public void test() {
		List localList = GetBspInfo.getBspInfo().getFunctionAuthorities();
		ArrayList localArrayList = new ArrayList();
		Iterator localIterator2 = localList.iterator();
		while (localIterator2.hasNext()) {
			Operation localOperation = (Operation) localIterator2.next();
			localArrayList.add(localOperation.getFunctionCode());
		}

		List<Map> allMenuList = fisCremationRateDomain.queryTest();
		int i = 0;
		Object localObject2;
		Object localObject3;
		Object localObject4;
		HashMap localHashMap = new HashMap();
		Menu localMenu1 = new Menu();
		localMenu1.setId("root");
		DataSet localDataSet = new DataSet(); // ...
		ArrayList localArrayList1 = new ArrayList();
		ArrayList localArrayList2 = new ArrayList();
		Object localObject1 = new ArrayList();
		if (true) {
			for (i = 0; i < allMenuList.size(); ++i) {
				localObject2 = (Map) allMenuList.get(i);
				if (!(isMenuPermit((Map) localObject2, localArrayList)))
					continue;
				localArrayList2.add(localObject2);
			}
			for (i = 0; i < localArrayList2.size(); ++i) {
				localObject2 = (Map) localArrayList2.get(i);
				localObject3 = (String) ((Map) localObject2).get("menuId");
				if ((((Map) localObject2).get("isLeaf") == null) || (!(((Map) localObject2).get("isLeaf").equals("1")))) {
					localObject4 = getLeaf((String) localObject3, localArrayList2);
					if (localObject4 != null)
						((List) localObject1).add(localObject2);
				} else {
					((List) localObject1).add(localObject2);
				}
			}
		} else {
			localObject1 = allMenuList;
		}
		for (i = 0; i < ((List) localObject1).size(); ++i) {
			localObject2 = (Map) ((List) localObject1).get(i);
			buildMenu((Map) localObject2, localHashMap, localDataSet);
		}
		for (i = 0; i < ((List) localObject1).size(); ++i) {
			localObject2 = (Map) ((List) localObject1).get(i);
			localObject3 = getParentChild((Map) localObject2, (List) localObject1);
			relation((Map) localObject2, (Map) localObject3, localHashMap);
		}
		for (i = 0; i < ((List) localObject1).size(); ++i) {
			localObject2 = (Map) ((List) localObject1).get(i);
			localObject3 = (String) ((Map) localObject2).get("parentId");
			localObject4 = (String) ((Map) localObject2).get("menuId");
			Menu localMenu2 = (Menu) localHashMap.get(localObject4);
			if (((String) localObject3).equals(localObject4))
				localArrayList1.add(localMenu2);
		}
		Iterator localIterator = localArrayList1.iterator();
		while (localIterator.hasNext()) {
			localObject2 = (Menu) localIterator.next();
			localMenu1.addChildren(localObject2);
		}
//		System.out.println(localMenu1.toXML());
	}

	private boolean isMenuPermit(Map paramMap, List<String> paramList) {
		if ((paramMap.get("isLeaf") == null) || (!(paramMap.get("isLeaf").equals("1"))))
			return true;
		String str = (String) paramMap.get("functionCode");
		if ((str == null) || (str.equals("")))
			return true;
		return (paramList.contains(str));
	}

	private Map getLeaf(String paramString, List paramList) {
		Map localMap;
		Map localObject = null;
		ArrayList localArrayList = new ArrayList();
		for (int i = 0; i < paramList.size(); ++i) {
			localMap = (Map) paramList.get(i);
			String str1 = (String) localMap.get("parentId");
			String str2 = (String) localMap.get("menuId");
			String str3 = (String) localMap.get("isLeaf");
			if ((!(paramString.equals(str2))) && (paramString.equals(str1))) {
				if ((str3 != null) && (str3.equals("1"))) {
					localObject = localMap;
					return localObject;
				}
				localArrayList.add(localMap);
			}
		}
		if (!(localArrayList.isEmpty()))
			for (int i = 0; i < localArrayList.size(); ++i) {
				localMap = (Map) localArrayList.get(i);
				localObject = getLeaf((String) localMap.get("menuId"), paramList);
				if (localObject != null)
					return localObject;
			}
		return ((Map) localObject);
	}

	private void buildMenu(Map paramMap, Map<String, Menu> paramMap1, DataSet paramDataSet) {
		String str1 = (String) paramMap.get("menuId");
		if (paramMap1.containsKey(str1))
			return;
		Menu localMenu = new Menu();
		localMenu.setId(str1);
		localMenu.setTitle((String) paramMap.get("menuName"));
		localMenu.setText((String) paramMap.get("menuName"));
		localMenu.setTarget((String) paramMap.get("target"));
		localMenu.setIcon((String) paramMap.get("icon"));
		String str2 = getAppMenuUrl(paramMap, paramDataSet);
		localMenu.setUrl(str2);
		localMenu.setLink(str2);
		if ((paramMap.get("isLeaf") != null) && ("1".equals(paramMap.get("isLeaf"))))
			localMenu.setIsLeaf(true);
		else
			localMenu.setIsLeaf(false);
		paramMap1.put(str1, localMenu);
	}

	private String getAppMenuUrl(Map paramMap, DataSet paramDataSet) {
		String str1 = (String) paramMap.get("requestAction");
		if ((str1 != null) && (str1.startsWith("/")))
			str1 = str1.substring(1);
		StringBuffer localStringBuffer = new StringBuffer();
		if ((str1 != null) && (!("".equals(str1))))
			if ((paramMap.get("appCode") != null) && (!(paramMap.get("appCode").equals("-1"))) && (!(paramMap.get("appCode").equals("")))) {
				String str2 = (String) paramMap.get("appCode");
				String str3 = null;
				for (int i = 0; i < paramDataSet.getCount(); ++i)
					if (str2.equals(paramDataSet.getRecord(i).get("appCode"))) {
						str3 = (String) paramDataSet.getRecord(i).get("uri");
						break;
					}
				if (str3.lastIndexOf("/") == str3.length() - 1)
					str3 = str3.substring(0, str3.length() - 1);
				localStringBuffer.append(str3).append("/").append(str1);
			} else {
				localStringBuffer.append(str1);
			}
		return localStringBuffer.toString();
	}

	private Map getParentChild(Map paramMap, List<Map> paramList) {
		Object localObject = null;
		if (paramMap.get("parentId").equals(paramMap.get("menuId"))) {
			localObject = paramMap;
		} else {
			String str1 = (String) paramMap.get("menuPath");
			if (str1.indexOf("#") < 0)
				return null;
			String str2 = str1.substring(0, str1.lastIndexOf("#"));
			Iterator localIterator = paramList.iterator();
			while (localIterator.hasNext()) {
				Map localMap = (Map) localIterator.next();
				if ((str2.equals(localMap.get("menuPath").toString().trim())) && (localMap.get("menuId").equals(paramMap.get("parentId")))) {
					localObject = localMap;
					break;
				}
			}
		}
		return ((Map) localObject);
	}

	private void relation(Map paramMap1, Map paramMap2, Map paramMap3) {
		String str1 = (String) paramMap1.get("menuId");
		String str2 = (String) paramMap1.get("parentId");
		if ((str1.equals(str2)) || (paramMap2 == null))
			return;
		Menu localMenu1 = (Menu) paramMap3.get(str1);
		Menu localMenu2 = (Menu) paramMap3.get((String) paramMap2.get("menuId"));
		if (localMenu2 != null)
			localMenu2.addChildren(localMenu1);
	}
}