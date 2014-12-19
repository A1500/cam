package com.inspur.cams.drel.ensureInfo.cmd;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import com.inspur.cams.drel.ensureInfo.data.EnsureToClient;
import com.inspur.cams.drel.ensureInfo.domain.IEnsureToClientDomain;
import com.inspur.cams.drel.sam.domain.ISamApplyInfoDomain;

/**
 * 核查业务反馈表cmd
 * @author 
 * @date 2014-07-23
 */
public class EnsureToClientCmd extends BaseAjaxCommand {

	private IEnsureToClientDomain ensureToClientDomain = ScaComponentFactory
			.getService(IEnsureToClientDomain.class, "ensureToClientDomain/ensureToClientDomain");
	
	private ISamApplyInfoDomain samApplyInfoDomain = ScaComponentFactory
			.getService(ISamApplyInfoDomain.class, "samApplyInfoDomain/samApplyInfoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		EnsureToClient ensureToClient = (EnsureToClient) record.toBean(EnsureToClient.class);
		ensureToClientDomain.insert(ensureToClient);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		EnsureToClient ensureToClient = (EnsureToClient) record.toBean(EnsureToClient.class);
		ensureToClientDomain.update(ensureToClient);
	}
	
	// 删除
	public void delete() {
		String ensureId = (String) getParameter("ensureId");
		ensureToClientDomain.delete(ensureId);
	}
	
	/**  用于设备控制导出控制文件使用
	 * @Title:createXML
	 * @Description:导出xml
	 * @throws FileNotFoundException
	 * @author:Administrator
	 */
	public void createXML() throws FileNotFoundException {
		ParameterSet pset=getParameterSet();
		DataSet ds = samApplyInfoDomain.queryExport(pset);
		
//		Record[] records = (Record[]) getParameter("records");
		Document doc = null;
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		
		
		try {
			///根据数据字段定义节点名称
			String []node_name={"SHEBEIMC"};
			DocumentBuilder docBuilder = dbf.newDocumentBuilder();
			doc = docBuilder.newDocument();	
//			doc.appendChild(doc.createComment("管控命令"));//添加注释
			Element rowdata = doc.createElement("ROWDATA");
			for(int i=0;i<ds.getCount();i++){
//				gkml.appendChild(doc.createComment("立即关机"));
//				Element row = doc.createElement("ROW");
//				
//				Element co = doc.createElement("CO");
//				co.setTextContent(i+"");
//				row.appendChild(co);
				Element family = doc.createElement("FAMILY");
				
				Element applyId = doc.createElement("APPLY_ID");
				applyId.setTextContent((String)ds.getRecord(i).get("APPLY_ID"));
				family.appendChild(applyId);
				
				Element familyName = doc.createElement("FAMILY_NAME");
				familyName.setTextContent((String)ds.getRecord(i).get("FAMILY_NAME"));
				family.appendChild(familyName);
				
				Element name = doc.createElement("NAME");
				name.setTextContent((String)ds.getRecord(i).get("NAME"));
				family.appendChild(name);
				
				Element idCard = doc.createElement("ID_CARD");
				idCard.setTextContent((String)ds.getRecord(i).get("ID_CARD"));
				family.appendChild(idCard);
				
				Element birthday = doc.createElement("BIRTHDAY");
				birthday.setTextContent((String)ds.getRecord(i).get("BIRTHDAY"));
				family.appendChild(birthday);
				
				Element sex = doc.createElement("SEX");
				sex.setTextContent((String)ds.getRecord(i).get("SEX"));
				family.appendChild(sex);
				
				Element relationshipType = doc.createElement("RELATIONSHIP_TYPE");
				relationshipType.setTextContent((String)ds.getRecord(i).get("RELATIONSHIP_TYPE"));
				family.appendChild(relationshipType);
				
				rowdata.appendChild(family);
				
				
			}
			doc.appendChild(rowdata);
			
			TransformerFactory tf = TransformerFactory.newInstance();
			Transformer transformer = tf.newTransformer();
			String datetime=new SimpleDateFormat("yyyy-MM-ddHHmmss").format(Calendar.getInstance().getTime());
			String path = "c://核查人员信息//";
			File f = new File(path);
			if (!f.exists()) {
				f.mkdirs();
			}
			String fileName ="核查人员信息_"+datetime+".xml";
			File file = new File(f, fileName);
			if (!file.exists()) {
				try {
					file.createNewFile();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			FileOutputStream out = new FileOutputStream(file);
			StreamResult xmlResult = new StreamResult(out);
			transformer.setOutputProperty(OutputKeys.INDENT, "yes");
			transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "4");///换行
			transformer.transform(new DOMSource(doc), xmlResult);
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (TransformerConfigurationException e) {
			e.printStackTrace();
		} catch (TransformerException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			throw e;
		}
	}
	public void importXML(){
		ParameterSet pset=getParameterSet();
		ensureToClientDomain.importXML(pset);
	}
	
}